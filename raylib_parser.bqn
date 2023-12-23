# Command line variables
inFileName ← "../src/raylib.h"
outFileName ← "raylib_api.txt"
apiDefine ← "RLAPI"       # Functions define (i.e. RLAPI for raylib.h, RMDEF for raymath.h, etc.)
truncAfter ← ""           # Truncate marker (i.e. "RLGL IMPLEMENTATION" for rlgl.h)

"
    raylib API parser

    This parser scans raylib.h to get API information about defines, structs, aliases, enums, callbacks and functions.
    All data is divided into pieces, usually as strings. The following types are used for data:

     - struct DefineInfo
     - struct StructInfo
     - struct AliasInfo
     - struct EnumInfo
     - struct FunctionInfo

    CONSTRAINTS:

    This parser is specifically designed to work with raylib.h, so, it has some constraints:

     - Functions are expected as a single line with the following structure:

       <retType> <name>(<paramType[0]> <paramName[0]>, <paramType[1]> <paramName[1]>);  <desc>

       Be careful with functions broken into several lines, it breaks the process!

     - Structures are expected as several lines with the following form:

       <desc>
       typedef struct <name> {
           <fieldType[0]> <fieldName[0]>;  <fieldDesc[0]>
           <fieldType[1]> <fieldName[1]>;  <fieldDesc[1]>
           <fieldType[2]> <fieldName[2]>;  <fieldDesc[2]>
       } <name>;

     - Enums are expected as several lines with the following form:

       <desc>
       typedef enum {
           <valueName[0]> = <valueInteger[0]>, <valueDesc[0]>
           <valueName[1]>,
           <valueName[2]>, <valueDesc[2]>
           <valueName[3]>  <valueDesc[3]>
       } <name>;

       NOTE: Multiple options are supported for enums:
          - If value is not provided, (<valueInteger[i -1]> + 1) is assigned
          - Value description can be provided or not

    OTHER NOTES:

     - This parser could work with other C header files if mentioned constraints are followed.
     - This parser does not require <string.h> library, all data is parsed directly from char buffers.
**********************************************************************************************/
"
max_structs_to_parse    ←   64 # Maximum number of structures to parse
max_aliases_to_parse    ←   64 # Maximum number of aliases to parse
max_enums_to_parse      ←   64 # Maximum number of enums to parse
max_callbacks_to_parse  ←   64 # Maximum number of callbacks to parse
max_funcs_to_parse      ← 1024 # Maximum number of functions to parse
max_line_length         ←  512 # Maximum length of one line (including comments)
max_struct_fields       ←   64 # Maximum number of struct fields
max_enum_values         ←  512 # Maximum number of enum values
max_function_parameters ←   12 # Maximum number of function parameters

If      ← {𝕏⍟𝕎@}´                 # Also Repeat
IfElse  ← {c‿T‿F: c◶F‿T@}
While   ← {𝕩•_while_𝕨@}´          # While 1‿{... to run forever
DoWhile ← {𝕏@ ⋄ While 𝕨‿𝕩}´
For     ← {I‿C‿P‿A: I@ ⋄ While⟨C,P∘A⟩}

# Switch/case statements have many variations; these are a few
Match   ← {𝕏𝕨}´
Select  ← {(⊑𝕩)◶(1↓𝕩)@}
Switch  ← {c←⊑𝕩 ⋄ [m,a]←⍉∘‿2⥊1↓𝕩 ⋄ (m⊸⊐⌾<C)◶a@}
Test    ← {fn←{C‿A𝕊e:C◶A‿E}´𝕩⋄Fn@}

tab←9+@

#----------------------------------------------------------------------------------
# Types and Structures Definition
#----------------------------------------------------------------------------------

# Type of parsed define
⟨
    unknown
    macro
    guard
    int
    int_math
    long
    long_math
    float
    float_math
    double
    double_math
    char
    string
    coloR
⟩ ← ↕14

# Struct info data
structInfo ← ⟨
    0‿64 ⥊""  # name       # Struct name
    0‿128⥊""  # desc       # Struct type description
    ↕0        # fieldCount # Number of fields in the struct
    0‿max_struct_fields‿64 ⥊""  # fieldType  # Field type
    0‿max_struct_fields‿64 ⥊""  # fieldName  # Field name
    0‿max_struct_fields‿128⥊""  # fieldDesc  # Field description
⟩

# Alias info data
aliasInfo ← ⟨
    0‿64 ⥊"" # type # Alias type
    0‿64 ⥊"" # name # Alias name
    0‿128⥊"" # desc # Alias description
⟩

# Enum info data
enumInfo ← ⟨
    0‿64 ⥊"" # name       # Enum name
    0‿128⥊"" # desc       # Enum description
    ↕0     # valueCount # Number of values in enumerator
    0‿max_enum_values‿64⥊""  # valueName    # Value name definition
    0‿max_enum_values⥊↕0     # valueInteger # Value integer
    0‿max_enum_values‿128⥊"" # valueDesc    # Value description
⟩

# Function info data
functionInfo ← ⟨
    0‿64 ⥊"" # name        # Function name
    0‿128⥊"" # desc        # Function description (comment at the end)
    0‿32 ⥊"" # retType     # Return value type
    ↕0       # paramCount  # Number of function parameters
    0‿max_function_parameters‿32 ⥊"" # paramType # Parameters type
    0‿max_function_parameters‿32 ⥊"" # paramName # Parameters name
    0‿max_function_parameters‿128⥊"" # paramDesc # Parameters description
⟩

#----------------------------------------------------------------------------------
# Module Functions Definition
#----------------------------------------------------------------------------------

# Get data type and name from a string containing both
# NOTE: Useful to parse function parameters and struct fields
GetDataTypeAndName←{𝕊typeName:#‿type‿name: # const char *typeName, int typeNameLen, char *type, char *name)
    break ← 1
    For (k←≠typeName)‿{𝕊:break∧k>0}‿{𝕊:k-↩1}‿{𝕤
        ('*'=k⊑typeName)∨(' '=k⊑typeName) ∧ ','≠typeName⊑˜k-1?
            break↩0
            # Function name starts at this point (and ret type finishes at this point)
            k(↑⋈1⊸+⊸↓)typeName
        ;
        ('.'=k⊑typeName) ∧ 3=≠typeName? # Handle varargs ...);
            break↩0
            "..."‿"args"
        ;""‿""
    }
}

# Get comment from a line, do nothing if no comment in line
GetDescription ← {𝕊line: # str → description (str)
    c ← 0
    descStart ← ¯1
    lastSlash ← ¯2
    isValid ← 0
    
    {isValid ∧ (descStart=¯1) ∧ 𝕩≠' '?
        descStart ↩ c
    ;'/'=𝕩?
        isValid ↩ lastSlash=c-1
        lastSlash ↩ c
    ;@
    }¨line
    ""⍟(descStart≠¯1) (c-descStart)↑descStart↓line
}

# Compare two text strings, requires number of characters to compare
IsTextEqual{𝕊text1‿text2‿count:
    ≡´count↑¨text1‿text2
}

# Find first text occurrence within a string
TextFindIndex ← ⊑¯1∾˜/∘⍷

# Get string of define type
StrDefineType ← ⊑⟜⟨
    "UNKNOWN"
    "GUARD"
    "MACRO"
    "INT"
    "INT_MATH"
    "LONG"
    "LONG_MATH"
    "FLOAT"
    "FLOAT_MATH"
    "DOUBLE"
    "DOUBLE_MATH"
    "CHAR"
    "STRING"
    "COLOR"
⟩

# Preprocess buffer to get separate lines
# NOTE: GetTextLines() also removes leading spaces/tabs
lines ← •FLines inFileName

# Read struct lines
# Find structs
# starting with "typedef struct ... {" or "typedef struct ... ; \n struct ... {"
# ending with "} ... ;"
# i.e. excluding "typedef struct rAudioBuffer rAudioBuffer;" -> Typedef and forward declaration only
structLines ←/{
    [m1,m2]←"typedef struct"‿"struct"(⊣≡≠⊸↑)⌜𝕩
    m1∧m2«⊸∨<´∘⊐⟜"{;"¨𝕩
} lines

# Read alias lines
# Find aliases (lines with "typedef ... ...;")
aliasLines ← ("typedef"⊸(⊣≡≠⊸↑)¨∧2=(+´¨' '⊸=>∨`¨∘∊⟜";("))lines

# Read enum lines
# Read enum line
# Keep the line position in the array of lines,
# so, we can scan that position and following lines
# ignore inline enums
enumLines ← ("typedef enum {"⊸(⊣≡≠⊸↑)∧∨´∘=⟜';')¨lines

# Read callback lines
callbackLines ← {
    # Find callbacks (lines with "typedef ... (* ... )( ... );")
    m1←"typedef"⊸(⊣≡≠⊸↑)¨lines
    m1∧{(");"⊸≡˘∨`⊸<")("⊸≡˘∧"(*"⊸≡˘)2↕𝕩}¨lines
}

# Read function lines
# Read function line (starting with `define`, i.e. for raylib.h "RLAPI")
funcLines ← apiDefine⊸(⊣≡≠⊸↑)¨lines

# At this point we have all raylib defines, structs, aliases, enums, callbacks, functions lines data to start parsing

# Parsing raylib data
#----------------------------------------------------------------------------------

# Define info data
defineIndicies ← {name‿type‿value‿desc‿isHex⇐↕5}

defMacro ← "#define"

CheckHex ← ¬∨´∘∊⟜"0123456789abcdefABCDEFxL.+-"

defines ← {
    linePtrs ← ↓⟜lines¨/defMacro⊸(⊣≡≠⊸↑)¨∨`∘∊⟜' '‿t⊸/¨lines
    loopedOver ← linePtrs
    
    # Skip duplicates
    ∊∘{defineIndicies.name⊑𝕩}⊸/defines⊣{𝕊linePtr:
        defineOut ← ⟨
            "" # str  # Define name
            @  # int  # Define type
            "" # str  # Define value
            "" # str  # Define description
            0  # bool # Define is hex number (for types INT, LONG)
        ⟩
        LS ← {∨`¬𝕩∊' '‿tab} # leading spacing
        nameAndArgs ← RS⊸/{𝔽defMacro∾⁼𝔽}linePtr # Skip spaces and tabs, then defMacro, then spaces and tabs again

        # Extract name
        defineNameStart ← linePtr-○≠nameAndArgs
        
        openBraces ← +`-˝"()"=⌜nameAndArgs
        
        nameLen ← defineNameEnd ← (⌊´∘⊐⟜' '‿tab≤·⊑⊐⟜'(')◶⟨
            1+⊐⟜')'
            ⌊´⊐⟜' '‿tab
        ⟩ nameAndArgs

        name‿args ← nameLen(↑⋈LS⊸/∘↓)nameAndArgs

        # Determine type
        {𝕊:defineOut macro⌾(defineIndicies.type⊸⊑)↩}⍟⊢')'=¯1⊑name
        {𝕊:defineOut guard⌾(defineIndicies.type⊸⊑)↩}⍟⊢(0=≠args)∨'/'=⊑args

        {'"'=⊑args? defineOut string⌾(defineIndicies.type⊸⊑)↩
        ;args=○⊑"'"? defineOut char⌾(defineIndicies.type⊸⊑)↩
        ;"CLITERAL(Color)"≡15↑args? defineOut color⌾(defineIndicies.type⊸⊑)↩
        ;⊑args⊑⊸∊'0'+↕10? # Parsing numbers
            isFloat‿isNumber‿isHex ← ⟨
                ⊑∊⟜'.'
                ⊑∊⟜'x'
                CheckHex
            ⟩{𝕎𝕩}¨<m←∧`∘¬∘∊⟜' '‿tab⊸/args
            {𝕊:isFloat?
                defineOut (double‿float⊑˜'f'=¯1⊑m)⌾(defineIndicies.type⊸⊑)↩
            ;
                defineOut (int‿long⊑˜'L'=¯1⊑m)⌾(defineIndicies.type⊸⊑)↩
                defineOut isHex⌾(defineIndicies.isHex⊸⊑)↩
            }⍟⊢isNumber
        }

        # Extracting value
        fullValue ← ∨`⌾⌽∘¬∘∊⟜tab‿' '⊸/args/˜¬∨`0∾˜"//"⍷args
        value ← fullValue↓˜-⊑defineOut.type∊long‿float # Remove number postfix
        
        defineOut value⌾(defineIndicies.value⊸⊑)↩

        # Extracting description
        desc ← •Show ∨`∘≠⟜' '⊸/args↓˜2+⊑/"//"⍷args
        defineOut desc⌾(defineIndicies.desc⊸⊑)↩

        # Parse defines of type UNKNOWN to find calculated numbers
        breakHappened←0⥊˜≠defineOut.value
        {𝕤
            largestType ← unknown
            isMath ← 1

            For (c←0)‿{𝕊:c<≠valuePtr}‿{𝕊:c+↩1}‿{𝕤
                ch ← c⊑valuePtr

                # Skip operators and whitespace
                {𝕤
                    # Read number operand
                    ∨´ch="0123456789"?
                    isNumber‿isFloat ← 1‿0
                    break2 ← 1
                    {𝕤
                        {𝕊:isFloat↩1}⍟⊢ch='.'
                        {𝕊:isNumber↩0⋄break2↩0}⍟CheckHex ch
                        {𝕤
                            c+↩1
                            ch↩c⊑valuePtr
                        }⍟{𝕊:break2}@
                    }•_while_{𝕊:break2∧¬∨´ch="()*/ "∾@∾@+9}@
                    ¬◶{𝕤
                        # Found a valid number -> update largestType
                        numberType ← (¬isFloat)◶⟨
                            DOUBLE_MATH‿FLOAT_MATH ⊑˜'f'=⊢
                            INT_MATH‿LONG_MATH ⊑˜'L'=⊢
                        ⟩ valuePtr⊑˜c-1
                        {𝕊:largestType↩numberType}⍟⊢ numberType>largestType
                    }‿{𝕤
                        isMath↩0
                    } isNumber
                    ;
                    # Read string operand
                    operandStart ← c
                    {𝕊:c+↩1⋄ch↩c⊑valuePtr}•_while_{𝕊:¬∨´ch=" ()+-*/"∾@}@
                    operandEnd ← c
                    operandLength ← operandEnd-operandStart

                    # Search previous defines for operand
                    foundOperand ← 0
                    break1 ← 1
                    For (previousDefineIndex←0)‿{𝕊:break∧previousDefineIndex<defineIndex}‿{𝕊:previousDefineIndex+↩1}‿{𝕤
                        defines[previousDefineIndex].name ≡○(operandLength⊸↑) operandStart↓valuePtr?
                            break1↩0
                            (≥⟜int∧≤⟜double_math) defines[previousDefineIndex].type?
                                # Found operand and it's a number -> update largestType
                                largestType ⌈↩ defines[previousDefineIndex].type
                                foundOperand ← 1
                    }
                    {𝕊:isMath↩0}⍟¬foundOperand
                }⍟¬∨´ch="()+-*/ "∾@+9
            }
            {𝕤
                # Define is a calculated number -> update type
                largestType ↩ {
                    𝕩 = int    ? int_math
                    𝕩 = long   ? long_math
                    𝕩 = float  ? float_math
                    𝕩 = double ? double_math
                } largestType
                defineOut.type ← largestType
            }⍟⊢isMath
        }⍟⊢defineOut.type=unknown

        defineOut
    }¨loopedOver
}
defineCount ← ≠defines

# Structs info data
structs ← {𝕤
    linesPtr ← 𝕩↓lines
    thisStruct ← structInfo

    # Parse struct description
    thisStruct.desc ↩ GetDescription ¯1⊑linesPtr

    # Get struct name: typedef struct name {
    tds_len ← ≠"typedef struct "
    break←1
    For (c←tds_len)‿{𝕊:break∧c<64+tds_len}‿{c+↩1}‿{𝕤
        ∨´linesPtr[0][c]=" {"?
            nameLen ← c - tds_len
            {𝕊:nameLen-↩1}•_while_{𝕊:' '=linesPtr[0][tds_len + nameLen - 1]}@
            thisStruct.name ⊢○(nameLen⊸↑)↩ tds_len↓0⊑linesPtr
            break↩0
    }

    # Get struct fields and count them -> fields finish with ;
    l ← 1
    {
        # WARNING: Some structs have empty spaces and comments -> OK, processed
        {𝕤
            # Scan one field line
            fieldLine ← l⊑linesPtr
            fieldEndPos ← ⊑fieldLine⊐';'

            {𝕤 # Field line is not a comment and not a struct declaration
                # Get struct field type and name
                thisStruct.fieldType[thisStruct.fieldCount] ‿ thisStruct.fieldName[thisStruct.fieldCount] ← GetDataTypeAndName fieldEndPos↑fieldLine

                # Get the field description
                thisStruct.fieldDesc[thisStruct.fieldCount] ↩ GetDescription fieldEndPos↓fieldLine

                thisStruct.fieldCount+↩1

                # Split field names containing multiple fields (like Matrix)
                additionalFields ← 0
                originalIndex ← thisStruct.fieldCount - 1
                For (c←0)‿{𝕊:c<≠thisStruct.fieldName[originalIndex]}‿{𝕊:c+↩1}‿{
                    {𝕊:additionalFields+↩1}⍟⊢thisStruct.fieldName[originalIndex][c] = ','
                }

                {𝕤
                    int originalLength ← ¯1
                    lastStart←0
                    For (c←0)‿{𝕊:c < 1+≠thisStruct.fieldName[originalIndex]}‿{𝕊:c+↩1}‿{𝕤
                        v ← thisStruct.fieldName[originalIndex][c]
                        isEndOfString ← v = @
                        {𝕤
                            {
                                originalLength=¯1?
                                    # Save length of original field name
                                    # Don't truncate yet, still needed for copying
                                    originalLength ↩ c
                                ;
                                # Copy field data from original field
                                nameLength ← c-lastStart
                                thisStruct.fieldName[thisStruct.fieldCount] ↩ nameLength ↑ thisStruct.fieldName[originalIndex][lastStart]
                                thisStruct.fieldType[thisStruct.fieldCount] ↩ thisStruct.fieldType[originalIndex][0]
                                thisStruct.fieldDesc[thisStruct.fieldCount] ↩ thisStruct.fieldDesc[originalIndex][0]
                                thisStruct.fieldCount+↩1
                            }
                            
                            {𝕤
                                # Skip comma and spaces
                                c+↩1
                                {𝕊:c+↩1}•_while_{𝕊:' '=thisStruct.fieldName[originalIndex][c]}@

                                # Save position for next field
                                lastStart ↩ c
                            }⍟¬isEndOfString
                        }⍟⊢isEndOfString∨v=','
                    }
                    # Set length of original field to truncate the first field name
                    thisStruct.fieldName[originalIndex][originalLength] ↩ @
                }⍟⊢additionalFields>0

                # Split field types containing multiple fields (like MemNode)
                additionalFields ← 0
                originalIndex ← thisStruct.fieldCount - 1
                For (c = 0)‿{𝕊:c<≠thisStruct.fieldType[originalIndex]}‿{𝕊:c+↩1}‿{𝕤
                    additionalFields+↩thisStruct.fieldType[originalIndex][c] = ','
                }

                {𝕤
                    # Copy original name to last additional field
                    thisStruct.fieldCount +↩ additionalFields
                    thisStruct.fieldName[originalIndex + additionalFields]↩ (≠thisStruct.fieldName[originalIndex])↑thisStruct.fieldName[originalIndex][0]

                    # Copy names from type to additional fields
                    fieldsRemaining ← additionalFields
                    nameStart ← ¯1
                    nameEnd ← ¯1
                    For (k←≠thisStruct.fieldType[originalIndex])‿{𝕊:k>0}‿{k-↩1}‿{𝕤
                        ∨´"* ,"=thisStruct.fieldType[originalIndex][k]?
                            {𝕤
                                # Don't copy to last additional field
                                {𝕤
                                    nameStart ↩ k + 1
                                    thisStruct.fieldName[originalIndex + fieldsRemaining] ↩(nameEnd - nameStart + 1)↑thisStruct.fieldType[originalIndex][nameStart]
                                }⍟⊢fieldsRemaining≠additionalFields
                                nameEnd ↩ ¯1
                                fieldsRemaining-↩1
                            }⍟⊢nameEnd≠¯1
                        ;
                            nameEnd=¯1? nameEnd ↩ k
                        ;@
                    }

                    # Truncate original field type
                    fieldTypeLength ← nameStart
                    thisStruct.fieldType[originalIndex][fieldTypeLength] ↩ @

                    # Set field type and description of additional fields
                    For (j←1)‿{𝕊:j≤additionalFields}‿{𝕊:j+↩1}‿{𝕤
                        thisStruct.fieldType[originalIndex + j] ↩ fieldTypeLength                       ↑thisStruct.fieldType[originalIndex][0]
                        thisStruct.fieldDesc[originalIndex + j] ↩ (≠thisStruct.fieldDesc[originalIndex])↑thisStruct.fieldDesc[originalIndex][0]
                    }
                }⍟⊢additionalFields > 0
            }⍟⊢∧´"struct"‿"/"≢¨6‿1↑¨<fieldLine
        }⍟⊢∧´(' '∾@+9)≠⊑l⊑linesPtr

        l+↩1
    }•_while_{𝕊:'}'≠⊑l⊑linesPtr}@

    thisStruct.fieldType[j] ← ⟨⟩

    # Move array sizes from name to type
    For (j←0)‿{𝕊:j < thisStruct.fieldCount}‿{𝕊:j+↩1}‿{
        # Move array size from name to type
        thisStruct.fieldType[j] ∾⟜<↩ 1↓¯1↓∨`∘=⟜'['⊸/ thisStruct.fieldName[j]
    }
}¨structLines

# Alias info data
aliases ← {𝕤
    # Description from previous line
    thisaliasInfo←aliasInfo
    thisaliasInfo.desc↩GetDescription lines[𝕩 - 1]

    linePtr ← 𝕩⊑lines

    c ← ≠"typedef "

    # Type
    typeStart ← c
    {𝕊:c+↩1}•_while_{𝕊:linePtr[c]≠' '}@
    typeLen ← c - typeStart
    thisaliasInfo.type ↩ typeLen↑linePtr[typeStart]

    # Skip space
    c+↩1

    # Name
    nameStart ← c
    {𝕊:c+↩1}•_while_{𝕊:linePtr[c]≠';'}@
    nameLen ← c - nameStart
    thisaliasInfo.name↩nameLen↑linePtr[nameStart]

    # Description
    thisaliasInfo.desc ↩ GetDescription c⊑linePtr
}¨aliaslines

enums ← {
    thisenumInfo←enumInfo
    # Parse enum description
    # NOTE: This is not necessarily from the line immediately before,
    # some of the enums have extra lines between the "description"
    # and the typedef enum
    break ← 1
    For (j←𝕩-1)‿{𝕊:break∧j > 0}‿{j-↩1}‿{𝕤
        linePtr ← j⊑lines
        {𝕤
            thisenumInfo.desc ↩ GetDescription lines⊑˜j+1
            break↩0
        }⍟⊢('/'≠⊑linePtr) ∨ ' '≠2⊑linePtr
    }
    break↩1
    For (j=1)‿{𝕊:break∧j<max_enum_values×2}‿{j+↩1}‿{   # Maximum number of lines following enum first line
        linePtr ← lines⊑˜j+i⊑enumLines

        (≥⟜'A'∧'Z'⊸≥)linePtr[0]?
            # Parse enum value line, possible options:
            #ENUM_VALUE_NAME,
            #ENUM_VALUE_NAME
            #ENUM_VALUE_NAME     = 99
            #ENUM_VALUE_NAME     = 99,
            #ENUM_VALUE_NAME     = 0x00000040,   # Value description

            # We start reading the value name
            c ← 0
            {𝕤
                thisenumInfo.valueName[thisenumInfo.valueCount][c] ↩ linePtr[c]
                c+↩1
            }•_while_{𝕊:∧´(c⊑linePtr)≠", ="∾@}@

            # After the name we can have:
            #  '='  -> value is provided
            #  ','  -> value is equal to previous + 1, there could be a description if not '\0'
            #  ' '  -> value is equal to previous + 1, there could be a description if not '\0'
            #  '\0' -> value is equal to previous + 1

            # Let's start checking if the line is not finished
            {(≠⟜','∧≠⟜@)c⊑linePtr?
                # Two options:
                #  '='  -> value is provided
                #  ' '  -> value is equal to previous + 1, there could be a description if not '\0'
                foundValue ← 0
                 
                {𝕤
                    {𝕤
                        foundValue ↩ 1
                        break↩0
                    }⍟⊢'='=linePtr[c]
                    c+↩1
                }•_while_{𝕊:∧´@‿'/'≠c⊑linePtr}@

                {foundValue?
                    c+↩1+' '=linePtr⊑˜c+1

                    # Parse integer value
                    n←0
                    integer ← ⟨⟩

                    {
                        integer[n] ↩ linePtr[c]
                        c+↩1 ⋄ n+↩1
                    }⍟⊢∧´','‿' '‿@≠c⊑linePtr

                    thisenumInfo.valueInteger[thisenumInfo.valueCount] ↩ •ParseFloat integer
                ;
                    thisenumInfo.valueInteger[thisenumInfo.valueCount] ↩ 1+thisenumInfo.valueInteger[thisenumInfo.valueCount - 1]
                }
            ;
                thisenumInfo.valueInteger[thisenumInfo.valueCount] ↩ 1+thisenumInfo.valueInteger[thisenumInfo.valueCount - 1]
            }

            # Parse value description
            thisenumInfo.valueDesc[thisenumInfo.valueCount] ↩ GetDescription c⊑linePtr

            thisenumInfo.valueCount+↩1
    ;
        linePtr[0] = '}'?
        
            # Get enum name from typedef
            c ← 0
            {𝕤
                thisenumInfo.name[c] ↩ linePtr⊑˜2 + c
                c+↩1
            }•_while_{𝕊:';'≠linePtr⊑˜2+c}@

            break↩0  # Enum ended, break for() loop
    ;@
    }
}¨enumLines

callbacks ← {
    thisfunctionInfo←functioninfo
    linePtr ← lines⊑˜𝕩

    # Skip "typedef "
    c ← 8

    # Return type
    retTypeStart ← c
    {𝕊:c+↩1}•_while_{𝕊:'('≠c⊑linePtr}@
    retTypeLen ← c - retTypeStart
    {𝕊:retTypeLen-↩1}•_while_{𝕊:' '=linePtr⊑˜retTypeStart+retTypeLen-1}
    thisfunctionInfo.retType ↩ retTypeLen↑linePtr⊑˜retTypeStart

    # Skip "(*"
    c +↩ ≠"(*"

    # Name
    nameStart←c
    {𝕊:c+↩1}•_while_{𝕊:')'≠linePtr⊑˜c}@
    nameLen ← c - nameStart
    thisfunctionInfo.name↩nameLen↑linePtr⊑˜nameStart

    # Skip ")("
    c +↩ ≠")("

    # Params
    paramStart ← c
    break←1
    For c‿{𝕊:break∧c<max_line_length}‿{𝕊:c+↩1}‿{𝕤
        {𝕤
            # Get parameter type + name, extract info
            paramLen ← c - paramStart
            thisfunctionInfo.paramType[thisfunctionInfo.paramCount]‿thisfunctionInfo.paramName[thisfunctionInfo.paramCount] ↩ GetDataTypeAndName (paramStart⊑linePtr)‿paramLen
            thisfunctionInfo.paramCount+↩1
            paramStart ↩ c+1
            {𝕊:paramStart+↩1}•_while_{𝕊:' '=paramStart⊑linePtr}
        }⍟⊢∨´"),"=c⊑linePtr
        {𝕊:break↩0}⍟⊢')'=c⊑linePtr
    }

    # Description
    thisfunctionInfo.desc ↩ GetDescription c⊑linePtr

    thisfunctionInfo.paramType[j] ← ⟨⟩

    # Move array sizes from name to type
    For (j←0)‿{𝕊:j<thisfunctionInfo.paramCount}‿{𝕊:j+↩1}‿{
        # Move array size from name to type
        thisfunctionInfo.paramType[j] ∾⟜<↩ 1↓¯1↓∨`∘=⟜'['⊸/ thisfunctionInfo.paramName[j]
    }
}¨callbackLines

funcs←{
    this2functionInfo←functionInfo
    linePtr ← lines⊑˜𝕩

    funcParamsStart ← 0
    funcEnd ← 0

    # Get return type and function name from func line
    break←1
    For (c←0)‿{𝕊:break∧(c<max_line_length)∧(c⊑linePtr)≠10+@}‿{𝕊:c+↩1}‿{𝕤
        # Starts function parameters
        {𝕤
            funcParamsStart ↩ c + 1

            # At this point we have function return type and function name
            dc ← 1+≠apiDefine
            funcRetTypeNameLen ← c-dc     # Substract `define` ("RLAPI " for raylib.h)
            funcRetTypeName ← funcRetTypeNameLen↑dc⊑linePtr

            this2functionInfo.retType‿this2functionInfo.name ↩ GetDataTypeAndName funcRetTypeName‿funcRetTypeNameLen
            break↩0
        }⍟⊢'('=c⊑linePtr
    }

    # Get parameters from func line
    break↩1
    For (c←funcParamsStart)‿{𝕊:break∧c<max_line_length}‿{𝕊:c+↩1}‿{
        linePtr[c] = ','?     # Starts function parameters
            # Get parameter type + name, extract info
            funcParamTypeNameLen ← c-funcParamsStart
            funcParamTypeName ← funcParamTypeNameLen↑funcParamsStart⊑linePtr

            this2functionInfo.paramType[this2functionInfo.paramCount] ‿ this2functionInfo.paramName[this2functionInfo.paramCount] ← GetDataTypeAndName funcParamTypeName‿funcParamTypeNameLen

            funcParamsStart ↩ c+1
            {𝕊:funcParamsStart +↩ 1}⍟⊢' '=linePtr⊑˜c+1
            this2functionInfo.paramCount+↩1      # Move to next parameter

        ; linePtr[c] = ')'?

            funcEnd ← c+2

            # Check if previous word is void
            {break↩0}⍟⊢(¯4↑linePtr)≡"void"
            break?
            # Get parameter type + name, extract info
            funcParamTypeNameLen ← c-funcParamsStart
            funcParamTypeName ← funcParamTypeNameLen↑funcParamsStart⊑linePtr

            this2functionInfo.paramType[this2functionInfo.paramCount] ‿ this2functionInfo.paramName[this2functionInfo.paramCount] ← GetDataTypeAndName funcParamTypeName‿funcParamTypeNameLen

            this2functionInfo.paramCount+↩1      # Move to next parameter
            break↩0
        ;@
    }

    # Get function description
    this2functionInfo.desc↩GetDescription funcEnd⊑linePtr

    this2functionInfo.paramType[j]←⟨⟩

    # Move array sizes from name to type
    For (j = 0)‿{𝕊:j < this2functionInfo.paramCount}‿{𝕊:j+↩1}‿{𝕤
        # Move array size from name to type
        this2functionInfo.paramType[j] ∾⟜<↩ 1↓¯1↓∨`∘=⟜'['⊸/ this2functionInfo.paramName[j]
    }
}¨funcLines

# At this point, all raylib data has been parsed!
#----------------------------------------------------------------------------------
# defines[]   -> We have all the defines decomposed into pieces for further analysis
# structs[]   -> We have all the structs decomposed into pieces for further analysis
# aliases[]   -> We have all the aliases decomposed into pieces for further analysis
# enums[]     -> We have all the enums decomposed into pieces for further analysis
# callbacks[] -> We have all the callbacks decomposed into pieces for further analysis
# funcs[]     -> We have all the functions decomposed into pieces for further analysis
•Out""
•Out"Input file:       "∾inFileName
•Out"Output file:      "∾outFileName

outFileName •FLines ParsedData@