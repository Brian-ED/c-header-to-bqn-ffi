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

    LICENSE: zlib/libpng

    raylib-parser is licensed under an unmodified zlib/libpng license, which is an OSI-certified,
    BSD-like license that allows static linking with closed source software:

    Copyright (c) 2021-2023 Ramon Santamaria (@raysan5)

**********************************************************************************************/
"
max_defines_to_parse    ← 2048 # Maximum number of defines to parse
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
FunctionInfo ← ⟨
    0‿64 ⥊"" # name        # Function name
    0‿128⥊"" # desc        # Function description (comment at the end)
    0‿32 ⥊"" # retType     # Return value type
    ↕0       # paramCount  # Number of function parameters
    0‿max_function_parameters‿32 ⥊"" # paramType # Parameters type
    0‿max_function_parameters‿32 ⥊"" # paramName # Parameters name
    0‿max_function_parameters‿128⥊"" # paramDesc # Parameters description
⟩

#----------------------------------------------------------------------------------
# Global Variables Definition
#----------------------------------------------------------------------------------
defineCount ← 0
structCount ← 0
aliasCount ← 0
enumCount ← 0
callbackCount ← 0
funcCount ← 0
defines ← @
structs ← @
aliases ← @
enums ← @
callbacks ← @
funcs ← @

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

# Export parsed data in json
ParsedData ← {𝕤
    ∾⟨
        "{"

        # Print defines info
        "  ""defines"": ["
        ¯1⊸↓⌾(¯1⊸⊑)∾{𝕊def:∾⟨
            ⋈"    {"
            ⋈"      ""name"": """∾def.name∾""","
            ⋈"      ""type"": """∾(StrDefineType def.type)∾""","
            {def.isHex? # INT or LONG
                "      ""value"": "∾(Strtol def.value‿NULL‿16)∾","
            ;∨´def.type = INT‿LONG‿FLOAT‿DOUBLE‿STRING?
                "      ""value"": "∾def.value∾','
            ;
                "      ""value"": """∾def.value∾""","
            }
            ⋈"      ""description"": """∾def.desc∾""""
            ⋈"    },"
        ⟩}¨defines
        "  ],"
        # Print structs info
        "  ""structs"": ["
        ¯1⊸↓⌾(¯1⊸⊑)∾{𝕊struct:⟨
            ⋈"    {"
            ⋈"      ""name"": """∾struct.name∾""","
            ⋈"      ""description"": """∾(EscapeBackslashes struct.desc)∾""","
            ⋈"      ""fields"": ["
            ∾¯1⊸↓⌾(¯1⊸⊑){𝕊f:⟨
                "        {"
                "          ""type"": """∾struct.fieldType[f]∾""","
                "          ""name"": """∾struct.fieldName[f]∾""","
                "          ""description"": """∾(EscapeBackslashes struct.fieldDesc[f])∾""""
                "        },"
            ⟩}¨↕struct.fieldCount
            ⋈"      ]"
            ⋈"    },"
        ⟩}¨structs
        "  ],"

        # Print aliases info
        "  ""aliases"": ["
        ¯1⊸↓⌾(¯1⊸⊑)∾{𝕊alias:⟨
            "    {"
            "      ""type"": """∾alias.type∾""","
            "      ""name"": """∾alias.name∾""","
            "      ""description"": """∾alias.desc∾'"'
            "    },"
        ⟩}¨aliases
        ⋈"  ],"

        # Print enums info
        ⋈"  ""enums"": ["
        ¯1⊸↓⌾(¯1⊸⊑)∾{𝕊enum:
            ∾⟨
                ⋈"    {"
                ⋈"      ""name"": """∾enum.name∾""","
                ⋈"      ""description"": """∾(EscapeBackslashes enum.desc)∾""","
                ⋈"      ""values"": ["
                ¯1⊸↓⌾(¯1⊸⊑)∾{𝕊e:
                    ⟨
                        "        {"
                        "          ""name"": """∾enum.valueName[e]∾""","
                        "          ""value"": "∾enum.valueInteger[e]∾","
                        "          ""description"": """∾(EscapeBackslashes enum.valueDesc[e])∾'"'
                        "        },"
                    ⟩
                }¨↕enum.valueCount
                ⋈"      ]"
                ⋈"    },"
            ⟩
        }↕enums
        ⋈"  ],"

        # Print callbacks info
        ⋈"  ""callbacks"": ["
        ¯1⊸↓⌾(¯1⊸⊑)∾{𝕊callback:∾⟨
            ⋈"    {"
            ⋈"      ""name"": """∾callback.name∾""","
            ⋈"      ""description"": """∾(EscapeBackslashes callback.desc)∾""",",
            ⋈"      ""returnType"": """∾callback.retType∾""","
            ⋈"      ""params"": ["
            ¯1⊸↓⌾(¯1⊸⊑)∾{𝕊p:
                "        {"
                "          ""type"": """∾callback.paramType[p]∾"""," 
                "          ""name"": """∾callback.paramName[p]∾""""  
                "        },"
            }¨↕callback.paramCount
            ⋈"      ]"
            ⋈"    },"
        ⟩}¨callbacks
        "  ],"

        # Print functions info
        ⋈"  ""functions"": ["
        ¯1⊸↓⌾(¯1⊸⊑)∾{𝕊func: ∾⟨
            ⋈"    {"
            ⋈"      ""name"": """∾func.name∾""","
            ⋈"      ""description"": """∾(EscapeBackslashes func.desc)∾""","
            ⋈"      ""returnType"": """∾func.retType∾""","
            ∾⟨
                "      ""params"": ["
                ∾{type𝕊name:⟨
                    "        {"
                    "          ""type"": """∾type∾""","
                    "          ""name"": """∾name∾'"'
                    "        }"
                    ","
                ⟩}¨´func.paramType‿func.paramName
                ⋈"      ]"
            ⟩
            "    },"
        ⟩}¨funcs
        ⋈"  ]"
        ⋈"}"
    ⟩
}

#----------------------------------------------------------------------------------
# Program main entry point
#----------------------------------------------------------------------------------

# Preprocess buffer to get separate lines
# NOTE: GetTextLines() also removes leading spaces/tabs
lines ← •FLines inFileName
linesCount ← ≠lines

# Defines line indices
defineLines ← max_defines_to_parse⥊0

# Structs line indices
structLines ← max_structs_to_parse⥊0

# Aliases line indices
aliasLines ← max_aliases_to_parse⥊0

# Enums line indices
enumLines ← max_enums_to_parse⥊0

# Callbacks line indices
callbackLines ← max_callbacks_to_parse⥊0

# Function line indices
funcLines ← max_funcs_to_parse⥊0

# Prepare required lines for parsing
#----------------------------------------------------------------------------------

# Read struct lines
# Find structs
# starting with "typedef struct ... {" or "typedef struct ... ; \n struct ... {"
# ending with "} ... ;"
# i.e. excluding "typedef struct rAudioBuffer rAudioBuffer;" -> Typedef and forward declaration only
structLines ← /{
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
structs ← max_structs_to_parse ⥊ structInfo

For (i←0)‿{𝕊:i<structCount}‿{𝕊:i+↩1}‿{
    linesPtr ← lines↓˜i⊑structLines

    # Parse struct description
    structs[i].desc ↩ GetDescription linesPtr[-1]

    # Get struct name: typedef struct name {
    tds_len ← ≠"typedef struct "
    break←1
    For (c←tds_len)‿{𝕊:break∧c<64+tds_len}‿{c+↩1}‿{𝕤
        ∨´linesPtr[0][c]=" {"?
            nameLen ← c - tds_len
            {𝕊:nameLen-↩1}•_while_{𝕊:' '=linesPtr[0][tds_len + nameLen - 1]}@
            structs[i].name ⊢○(nameLen⊸↑)↩ tds_len↓0⊑linesPtr
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
                structs[i].fieldType[structs[i].fieldCount] ‿ structs[i].fieldName[structs[i].fieldCount] ← GetDataTypeAndName fieldEndPos↑fieldLine

                # Get the field description
                structs[i].fieldDesc[structs[i].fieldCount] ↩ GetDescription fieldEndPos↓fieldLine

                structs[i].fieldCount+↩1

                # Split field names containing multiple fields (like Matrix)
                additionalFields ← 0
                originalIndex ← structs[i].fieldCount - 1
                For (c←0)‿{𝕊:c<≠structs[i].fieldName[originalIndex]}‿{𝕊:c+↩1}‿{
                    {𝕊:additionalFields+↩1}⍟⊢structs[i].fieldName[originalIndex][c] = ','
                }

                {𝕤
                    int originalLength ← ¯1
                    lastStart←0
                    For (c←0)‿{𝕊:c < 1+≠structs[i].fieldName[originalIndex]}‿{𝕊:c+↩1}‿{𝕤
                        v ← structs[i].fieldName[originalIndex][c]
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
                                structs[i].fieldName[structs[i].fieldCount] ↩ nameLength ↑ structs[i].fieldName[originalIndex][lastStart]
                                structs[i].fieldType[structs[i].fieldCount] ↩ structs[i].fieldType[originalIndex][0]
                                structs[i].fieldDesc[structs[i].fieldCount] ↩ structs[i].fieldDesc[originalIndex][0]
                                structs[i].fieldCount+↩1
                            }
                            
                            {𝕤
                                # Skip comma and spaces
                                c+↩1
                                {𝕊:c+↩1}•_while_{𝕊:' '=structs[i].fieldName[originalIndex][c]}@

                                # Save position for next field
                                lastStart ↩ c
                            }⍟¬isEndOfString
                        }⍟⊢isEndOfString∨v=','
                    }
                    # Set length of original field to truncate the first field name
                    structs[i].fieldName[originalIndex][originalLength] ↩ @
                }⍟⊢additionalFields>0

                # Split field types containing multiple fields (like MemNode)
                additionalFields ← 0
                originalIndex ← structs[i].fieldCount - 1
                For (c = 0)‿{𝕊:c<≠structs[i].fieldType[originalIndex]}‿{𝕊:c+↩1}‿{𝕤
                    additionalFields+↩structs[i].fieldType[originalIndex][c] = ','
                }

                {𝕤
                    # Copy original name to last additional field
                    structs[i].fieldCount +↩ additionalFields
                    structs[i].fieldName[originalIndex + additionalFields]↩ (≠structs[i].fieldName[originalIndex])↑structs[i].fieldName[originalIndex][0]

                    # Copy names from type to additional fields
                    fieldsRemaining ← additionalFields
                    nameStart ← ¯1
                    nameEnd ← ¯1
                    For (k←≠structs[i].fieldType[originalIndex])‿{𝕊:k>0}‿{k-↩1}‿{𝕤
                        ∨´"* ,"=structs[i].fieldType[originalIndex][k]?
                            {𝕤
                                # Don't copy to last additional field
                                {𝕤
                                    nameStart ↩ k + 1
                                    structs[i].fieldName[originalIndex + fieldsRemaining] ↩(nameEnd - nameStart + 1)↑structs[i].fieldType[originalIndex][nameStart]
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
                    structs[i].fieldType[originalIndex][fieldTypeLength] ↩ @

                    # Set field type and description of additional fields
                    For (j←1)‿{𝕊:j≤additionalFields}‿{𝕊:j+↩1}‿{𝕤
                        structs[i].fieldType[originalIndex + j] ↩ fieldTypeLength                       ↑structs[i].fieldType[originalIndex][0]
                        structs[i].fieldDesc[originalIndex + j] ↩ (≠structs[i].fieldDesc[originalIndex])↑structs[i].fieldDesc[originalIndex][0]
                    }
                }⍟⊢additionalFields > 0
            }⍟⊢∧´"struct"‿"/"≢¨6‿1↑¨<fieldLine
        }⍟⊢∧´(' '∾@+9)≠⊑l⊑linesPtr

        l+↩1
    }•_while_{𝕊:'}'≠⊑l⊑linesPtr}@

    structs[i].fieldType[j] ← ⟨⟩

    # Move array sizes from name to type
    For (j←0)‿{𝕊:j < structs[i].fieldCount}‿{𝕊:j+↩1}‿{
        # Move array size from name to type
        structs[i].fieldType[j] ∾⟜<↩ 1↓¯1↓∨`∘=⟜'['⊸/ structs[i].fieldName[j]
    }
}

# Alias info data
aliases ← max_aliases_to_parse⥊aliasInfo

For (i←0)‿{𝕊:i<aliasCount}‿{𝕊:i+↩1}‿{𝕤
    # Description from previous line
    aliases[i].desc↩GetDescription lines[aliasLines[i] - 1]

    linePtr ← lines[aliasLines[i]]

    c ← ≠"typedef "

    # Type
    typeStart ← c
    {𝕊:c+↩1}•_while_{𝕊:linePtr[c]≠' '}@
    typeLen ← c - typeStart
    aliases[i].type ↩ typeLen↑linePtr[typeStart]

    # Skip space
    c+↩1

    # Name
    nameStart ← c
    {𝕊:c+↩1}•_while_{𝕊:linePtr[c]≠';'}@
    nameLen ← c - nameStart
    aliases[i].name↩nameLen↑linePtr[nameStart]

    # Description
    aliases[i].desc ↩ GetDescription c⊑linePtr
}

# Enum info data
enums ← max_enums_to_parse⥊enumInfo

For (i←0)‿{𝕊:i<enumCount}‿{i+↩1}‿{

    # Parse enum description
    # NOTE: This is not necessarily from the line immediately before,
    # some of the enums have extra lines between the "description"
    # and the typedef enum
    break ← 1
    For (j←enumLines[i]-1)‿{𝕊:break∧j > 0}‿{j-↩1}‿{𝕤
        linePtr ← j⊑lines
        {𝕤
            enums[i].desc ↩ GetDescription lines⊑˜j+1
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
                enums[i].valueName[enums[i].valueCount][c] ↩ linePtr[c]
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

                    enums[i].valueInteger[enums[i].valueCount] ↩ •ParseFloat integer
                ;
                    enums[i].valueInteger[enums[i].valueCount] ↩ 1+enums[i].valueInteger[enums[i].valueCount - 1]
                }
            ;
                enums[i].valueInteger[enums[i].valueCount] ↩ 1+enums[i].valueInteger[enums[i].valueCount - 1]
            }

            # Parse value description
            enums[i].valueDesc[enums[i].valueCount] ↩ GetDescription c⊑linePtr

            enums[i].valueCount+↩1
    ;
        linePtr[0] = '}'?
        
            # Get enum name from typedef
            c ← 0
            {𝕤
                enums[i].name[c] ↩ linePtr⊑˜2 + c
                c+↩1
            }•_while_{𝕊:';'≠linePtr⊑˜2+c}@

            break↩0  # Enum ended, break for() loop
    ;@
    }
}

# Callback info data
callbacks ← max_callbacks_to_parse⥊functioninfo

For (i=0)‿{𝕊:i < callbackCount}‿{i+↩1}‿{
    linePtr ← lines⊑˜callbackLines⊑˜i

    # Skip "typedef "
    c ← 8

    # Return type
    retTypeStart ← c
    {𝕊:c+↩1}•_while_{𝕊:'('≠c⊑linePtr}@
    retTypeLen ← c - retTypeStart
    {𝕊:retTypeLen-↩1}•_while_{𝕊:' '=linePtr⊑˜retTypeStart+retTypeLen-1}
    callbacks[i].retType ↩ retTypeLen↑linePtr⊑˜retTypeStart

    # Skip "(*"
    c +↩ ≠"(*"

    # Name
    nameStart←c
    {𝕊:c+↩1}•_while_{𝕊:')'≠linePtr⊑˜c}@
    nameLen ← c - nameStart
    callbacks[i].name↩nameLen↑linePtr⊑˜nameStart

    # Skip ")("
    c +↩ ≠")("

    # Params
    paramStart ← c
    break←1
    For c‿{𝕊:break∧c<max_line_length}‿{𝕊:c+↩1}‿{𝕤
        {𝕤
            # Get parameter type + name, extract info
            paramLen ← c - paramStart
            callbacks[i].paramType[callbacks[i].paramCount]‿callbacks[i].paramName[callbacks[i].paramCount] ↩ GetDataTypeAndName (paramStart⊑linePtr)‿paramLen
            callbacks[i].paramCount+↩1
            paramStart ↩ c+1
            {𝕊:paramStart+↩1}•_while_{𝕊:' '=paramStart⊑linePtr}
        }⍟⊢∨´"),"=c⊑linePtr
        {𝕊:break↩0}⍟⊢')'=c⊑linePtr
    }

    # Description
    callbacks[i].desc ↩ GetDescription c⊑linePtr

    callbacks[i].paramType[j] ← ⟨⟩

    # Move array sizes from name to type
    For (j←0)‿{𝕊:j<callbacks[i].paramCount}‿{𝕊:j+↩1}‿{
        # Move array size from name to type
        callbacks[i].paramType[j] ∾⟜<↩ 1↓¯1↓∨`∘=⟜'['⊸/ callbacks[i].paramName[j]
    }
}

# Functions info data
funcs ← max_funcs_to_parse⥊functionInfo

For (i = 0)‿{𝕊:i < funcCount}‿{i+↩1}‿{
    linePtr ← lines⊑˜i⊑funcLines

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

            funcs[i].retType‿funcs[i].name ↩ GetDataTypeAndName funcRetTypeName‿funcRetTypeNameLen
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

            funcs[i].paramType[funcs[i].paramCount] ‿ funcs[i].paramName[funcs[i].paramCount] ← GetDataTypeAndName funcParamTypeName‿funcParamTypeNameLen

            funcParamsStart ↩ c+1
            {𝕊:funcParamsStart +↩ 1}⍟⊢' '=linePtr⊑˜c+1
            funcs[i].paramCount+↩1      # Move to next parameter

        ; linePtr[c] = ')'?

            funcEnd ← c+2

            # Check if previous word is void
            {break↩0}⍟⊢(¯4↑linePtr)≡"void"
            break?
            # Get parameter type + name, extract info
            funcParamTypeNameLen ← c-funcParamsStart
            funcParamTypeName ← funcParamTypeNameLen↑funcParamsStart⊑linePtr

            funcs[i].paramType[funcs[i].paramCount] ‿ funcs[i].paramName[funcs[i].paramCount] ← GetDataTypeAndName funcParamTypeName‿funcParamTypeNameLen

            funcs[i].paramCount+↩1      # Move to next parameter
            break↩0
        ;@
    }

    # Get function description
    funcs[i].desc↩GetDescription funcEnd⊑linePtr

    funcs[i].paramType[j]←⟨⟩

    # Move array sizes from name to type
    For (j = 0)‿{𝕊:j < funcs[i].paramCount}‿{𝕊:j+↩1}‿{𝕤
        # Move array size from name to type
        funcs[i].paramType[j] ∾⟜<↩ 1↓¯1↓∨`∘=⟜'['⊸/ funcs[i].paramName[j]
    }
}

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