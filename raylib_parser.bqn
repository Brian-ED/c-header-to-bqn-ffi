# Command line variables
inFileName ← "../src/raylib.h"
outFileName ← "raylib_api.txt"
apiDefine ← "RLAPI"       # Functions define (i.e. RLAPI for raylib.h, RMDEF for raymath.h, etc.)
truncAfter ← ""           # Truncate marker (i.e. "RLGL IMPLEMENTATION" for rlgl.h)

"
    raylib API parser

    This parser scans raylib.h to get API information about defines, structs, aliases, enums, callbacks and functions.
    All data is divided into pieces, usually as strings.

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
max_enum_values         ←  512 # Maximum number of enum values

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

#----------------------------------------------------------------------------------
# Module Functions Definition
#----------------------------------------------------------------------------------

# Get data type and name from a string containing both
# NOTE: Useful to parse function parameters and struct fields
GetDataTypeAndName←{𝕊typeName:#‿type‿name: # const char *typeName, int typeNameLen, char *type, char *name)
    o←@
    break ← 1
    For (k←≠typeName)‿{𝕊:break∧k>0}‿{𝕊:k-↩1}‿{𝕤
        ('*'=k⊑typeName)∨(' '=k⊑typeName) ∧ ','≠typeName⊑˜k-1?
            break↩0
            # Function name starts at this point (and ret type finishes at this point)
            o↩k(↑⋈1⊸+⊸↓)typeName
        ;
        ('.'=k⊑typeName) ∧ 3=≠typeName? # Handle varargs ...);
            break↩0
            o↩"..."‿"args"
        ;""‿""
    }
    o
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
        name ← ""
        type ← 0
        value ← ""
        description ← ""
        ishex ← 0

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
        {𝕊:type↩macro}⍟⊢')'=¯1⊑name
        {𝕊:type↩guard}⍟⊢(0=≠args)∨'/'=⊑args

        {'"'=⊑args? type↩string
        ;args=○⊑"'"? type↩char
        ;"CLITERAL(Color)"≡15↑args? type↩color
        ;⊑args⊑⊸∊'0'+↕10? # Parsing numbers
            isFloat‿isNumber‿isHex2 ← ⟨
                ⊑∊⟜'.'
                ⊑∊⟜'x'
                CheckHex
            ⟩{𝕎𝕩}¨<m←∧`∘¬∘∊⟜' '‿tab⊸/args
            {𝕊:isFloat?
                type↩double‿float⊑˜'f'=¯1⊑m
            ;
                type↩int‿long⊑˜'L'=¯1⊑m
                ishex↩isHex2
            }⍟⊢isNumber
        }

        # Extracting value
        fullValue ← ∨`⌾⌽∘¬∘∊⟜tab‿' '⊸/args/˜¬∨`0∾˜"//"⍷args
        value2 ← fullValue↓˜-⊑type∊long‿float # Remove number postfix
        
        value↩value2

        # Extracting description
        desc2 ← •Show ∨`∘≠⟜' '⊸/args↓˜2+⊑/"//"⍷args
        desc↩desc2

        # Parse defines of type UNKNOWN to find calculated numbers
        breakHappened←0⥊˜≠value
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
                    }•_while_{𝕊:break2∧¬∨´ch="()*/ "∾@∾tab}@
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
                }⍟¬∨´ch="()+-*/ "∾tab
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

        name‿type‿value‿description‿ishex
    }¨loopedOver
}

# Structs info data
structs ← {𝕤
    name←""
    desc←""
    fieldCount←⟨⟩
    fieldType←""
    fieldName←""
    fieldDesc←""

    linesPtr ← 𝕩↓lines

    # Parse struct description
    desc ↩ GetDescription ¯1⊑linesPtr

    # Get struct name: typedef struct name {
    tds_len ← ≠"typedef struct "
    break←1
    For (c←tds_len)‿{𝕊:break∧c<64+tds_len}‿{𝕊:c+↩1}‿{𝕤
        ∨´" {"=c⊑⊑linesPtr?
            nameLen ← c - tds_len
            {𝕊:nameLen-↩1}•_while_{𝕊:' '=linesPtr[0][tds_len + nameLen - 1]}@
            name ↩ nameLen↑tds_len↓0⊑linesPtr
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
                fieldType[fieldCount] ‿ fieldName[fieldCount] ← GetDataTypeAndName fieldEndPos↑fieldLine

                # Get the field description
                fieldDesc[fieldCount] ↩ GetDescription fieldEndPos↓fieldLine

                fieldCount+↩1

                # Split field names containing multiple fields (like Matrix)
                additionalFields ← 0
                originalIndex ← fieldCount - 1
                For (c←0)‿{𝕊:c<≠fieldName[originalIndex]}‿{𝕊:c+↩1}‿{
                    {𝕊:additionalFields+↩1}⍟⊢fieldName[originalIndex][c] = ','
                }

                {𝕤
                    int originalLength ← ¯1
                    lastStart←0
                    For (c←0)‿{𝕊:c < 1+≠fieldName[originalIndex]}‿{𝕊:c+↩1}‿{𝕤
                        v ← fieldName[originalIndex][c]
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
                                fieldName[fieldCount] ↩ nameLength ↑ fieldName[originalIndex][lastStart]
                                fieldType[fieldCount] ↩ fieldType[originalIndex][0]
                                fieldDesc[fieldCount] ↩ fieldDesc[originalIndex][0]
                                fieldCount+↩1
                            }
                            
                            {𝕤
                                # Skip comma and spaces
                                c+↩1
                                {𝕊:c+↩1}•_while_{𝕊:' '=fieldName[originalIndex][c]}@

                                # Save position for next field
                                lastStart ↩ c
                            }⍟¬isEndOfString
                        }⍟⊢isEndOfString∨v=','
                    }
                    # Set length of original field to truncate the first field name
                    fieldName[originalIndex][originalLength] ↩ @
                }⍟⊢additionalFields>0

                # Split field types containing multiple fields (like MemNode)
                additionalFields ← 0
                originalIndex ← fieldCount - 1
                For (c = 0)‿{𝕊:c<≠fieldType[originalIndex]}‿{𝕊:c+↩1}‿{𝕤
                    additionalFields+↩fieldType[originalIndex][c] = ','
                }

                {𝕤
                    # Copy original name to last additional field
                    fieldCount +↩ additionalFields
                    fieldName[originalIndex + additionalFields]↩ (≠fieldName[originalIndex])↑fieldName[originalIndex][0]

                    # Copy names from type to additional fields
                    fieldsRemaining ← additionalFields
                    nameStart ← ¯1
                    nameEnd ← ¯1
                    For (k←≠fieldType[originalIndex])‿{𝕊:k>0}‿{k-↩1}‿{𝕤
                        ∨´"* ,"=fieldType[originalIndex][k]?
                            {𝕤
                                # Don't copy to last additional field
                                {𝕤
                                    nameStart ↩ k + 1
                                    fieldName[originalIndex + fieldsRemaining] ↩(nameEnd - nameStart + 1)↑fieldType[originalIndex][nameStart]
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
                    fieldType[originalIndex][fieldTypeLength] ↩ @

                    # Set field type and description of additional fields
                    For (j←1)‿{𝕊:j≤additionalFields}‿{𝕊:j+↩1}‿{𝕤
                        fieldType[originalIndex + j] ↩ fieldTypeLength                       ↑fieldType[originalIndex][0]
                        fieldDesc[originalIndex + j] ↩ (≠fieldDesc[originalIndex])↑fieldDesc[originalIndex][0]
                    }
                }⍟⊢additionalFields > 0
            }⍟⊢∧´"struct"‿"/"≢¨6‿1↑¨<fieldLine
        }⍟⊢∧´' '‿tab≠⊑l⊑linesPtr

        l+↩1
    }•_while_{𝕊:'}'≠⊑l⊑linesPtr}@

    fieldType[j] ← ⟨⟩

    # Move array sizes from name to type
    For (j←0)‿{𝕊:j < fieldCount}‿{𝕊:j+↩1}‿{
        # Move array size from name to type
        fieldType[j] ∾⟜<↩ 1↓¯1↓∨`∘=⟜'['⊸/ fieldName[j]
    }
    name‿desc‿fieldCount‿fieldType‿fieldName‿fieldDesc
}¨structLines

# Alias info data
aliases ← {𝕤
    type←"" # Alias type
    name←"" # Alias name
    desc←"" # Alias description

    # Description from previous line

    linePtr ← 𝕩⊑lines

    c ← ≠"typedef "

    # Type
    typeStart ← c
    {𝕊:c+↩1}•_while_{𝕊:' '≠c⊑linePtr}@
    typeLen ← c - typeStart
    type ↩ typeLen↑typeStart↓linePtr

    # Skip space
    c+↩≠" "

    # Name
    nameStart ← c
    {𝕊:c+↩1}•_while_{𝕊:';'≠c⊑linePtr}@
    nameLen ← c - nameStart
    name↩nameLen↑nameStart↓linePtr

    # Description
    desc ⊣⍟(""⊸≡)↩ GetDescription lines⊑˜𝕩-1
    desc ↩ GetDescription c⊑linePtr
    type‿name‿desc
}¨aliaslines

enums ← {
    name         ← ""
    desc         ← ""
    valueCount   ← ⟨⟩
    valueName    ← ""
    valueInteger ← ⟨⟩
    valueDesc    ← ""

    # Parse enum description
    # NOTE: This is not necessarily from the line immediately before,
    # some of the enums have extra lines between the "description"
    # and the typedef enum
    break ← 1
    For (j←𝕩-1)‿{𝕊:break∧j > 0}‿{𝕊:j-↩1}‿{𝕤
        linePtr ← j⊑lines
        {𝕤
            desc ↩ GetDescription lines⊑˜j+1
            break↩0
        }⍟⊢('/'≠⊑linePtr) ∨ ' '≠2⊑linePtr
    }
    break↩1
    For (j=1)‿{𝕊:break∧j<max_enum_values×2}‿{𝕊:j+↩1}‿{𝕤   # Maximum number of lines following enum first line
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
                valueName[valueCount][c] ↩ linePtr[c]
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
                n←∧`'/'≠c↓linePtr
                foundValue ↩ ⊑'='∊n/c↓linePtr
                c+↩+´n

                {foundValue?
                    c+↩1+' '=linePtr⊑˜c+1

                    # Parse integer value
                    n←0
                    integer ← ⟨⟩

                    {𝕤
                        integer[n] ↩ linePtr[c]
                        c+↩1 ⋄ n+↩1
                    }⍟⊢∧´','‿' '‿@≠c⊑linePtr

                    valueInteger[valueCount] ↩ •ParseFloat integer
                ;
                    valueInteger[valueCount] ↩ 1+valueInteger[valueCount - 1]
                }
            ;
                valueInteger[valueCount] ↩ 1+valueInteger[valueCount - 1]
            }

            # Parse value description
            valueDesc[valueCount] ↩ GetDescription c⊑linePtr

            valueCount+↩1
    ;
        linePtr[0] = '}'?
        
            # Get enum name from typedef
            c ← 0
            {𝕤
                name[c] ↩ linePtr⊑˜2 + c
                c+↩1
            }•_while_{𝕊:';'≠linePtr⊑˜2+c}@

            break↩0  # Enum ended, break for() loop
    ;@
    }
    name‿desc‿valueCount‿valueName‿valueInteger‿valueDesc
}¨enumLines

callbacks ← {
    # Skip "typedef "
    c ← ≠"typedef"

    # Return type
    retTypeStart ← c
    c+↩+´∧`'('≠c↓𝕩
    retTypeLen ← c-retTypeStart
    retTypeLen-↩+´∧`' '≠⌽𝕩↑˜retTypeStart+retTypeLen-1
    retType ← retTypeLen↑retTypeStart↓𝕩

    # Skip "(*"
    c +↩ ≠"(*"

    # Name
    nameStart←c
    c+↩+´∧`')'≠c↓𝕩
    nameLen ← c - nameStart
    name ← nameLen↑nameStart↓𝕩

    # Skip ")("
    c +↩ ≠")("

    # Params
    paramStart ← c
    break←1
    
    # ⟨paramType‿paramName, ...⟩
    [paramTypes,paramNames] ← ⍉>GetDataTypeAndName¨ ',' ((⊢-˜+`×¬)∘=⊔⊢) ∧`∘≠⟜')'c↓linePtr
    # Move array sizes from name to type
    paramTypes∾¨↩1↓¨¯1↓¨∨`∘=⟜'['⊸/¨paramNames

    # Description
    desc ← GetDescription c↓𝕩

    paramCount←≠paramNames
    name‿desc‿retType‿paramCount‿paramTypes‿paramNames
}¨{
    # Read callback lines
    # Find callbacks (lines with "typedef ... (* ... )( ... );")
    m1←"typedef"⊸(⊣≡≠⊸↑)¨𝕩
    m1∧{(");"⊸≡˘∨`⊸<")("⊸≡˘∧"(*"⊸≡˘)2↕𝕩}¨𝕩
}⊸/lines

funcs←{
    name       ← ""
    desc       ← ""
    retType    ← ""
    paramCount ← ⟨⟩
    paramType  ← ""
    paramName  ← ""
    paramDesc  ← ""

    linePtr ← lines⊑˜𝕩

    funcParamsStart ← 0
    funcEnd ← 0

    # Get return type and function name from func line
    break←1
    For (c←0)‿{𝕊:break∧(c<≠linePtr)∧(c⊑linePtr)≠10+@}‿{𝕊:c+↩1}‿{𝕤
        # Starts function parameters
        {𝕤
            funcParamsStart ↩ c + 1

            # At this point we have function return type and function name
            dc ← 1+≠apiDefine
            funcRetTypeNameLen ← c-dc     # Substract `define` ("RLAPI " for raylib.h)
            funcRetTypeName ← funcRetTypeNameLen↑dc⊑linePtr

            retType‿name ↩ GetDataTypeAndName funcRetTypeName‿funcRetTypeNameLen
            break↩0
        }⍟⊢'('=c⊑linePtr
    }

    # Get parameters from func line
    break↩1
    For (c←funcParamsStart)‿{𝕊:break∧c<≠linePtr}‿{𝕊:c+↩1}‿{
        linePtr[c] = ','?     # Starts function parameters
            # Get parameter type + name, extract info
            funcParamTypeNameLen ← c-funcParamsStart
            funcParamTypeName ← funcParamTypeNameLen↑funcParamsStart⊑linePtr

            paramType[paramCount] ‿ paramName[paramCount] ← GetDataTypeAndName funcParamTypeName‿funcParamTypeNameLen

            funcParamsStart ↩ c+1
            {𝕊:funcParamsStart +↩ 1}⍟⊢' '=linePtr⊑˜c+1
            paramCount+↩1      # Move to next parameter

        ; linePtr[c] = ')'?

            funcEnd ← c+2

            # Check if previous word is void
            {break↩0}⍟⊢(¯4↑linePtr)≡"void"
            break?
            # Get parameter type + name, extract info
            funcParamTypeNameLen ← c-funcParamsStart
            funcParamTypeName ← funcParamTypeNameLen↑funcParamsStart⊑linePtr

            paramType[paramCount] ‿ paramName[paramCount] ← GetDataTypeAndName funcParamTypeName‿funcParamTypeNameLen

            paramCount+↩1      # Move to next parameter
            break↩0
        ;@
    }

    # Get function description
    desc↩GetDescription funcEnd⊑linePtr

    paramType[j]←⟨⟩

    # Move array sizes from name to type
    For (j←0)‿{𝕊:j < paramCount}‿{𝕊:j+↩1}‿{𝕤
        # Move array size from name to type
        paramType[j] ∾⟜<↩ 1↓¯1↓∨`∘=⟜'['⊸/ paramName[j]
    }
    name‿desc‿retType‿paramCount‿paramType‿paramName‿paramDesc
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