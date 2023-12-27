# Command line variables
inFileName ← "./examples/raylib/raylib.h"
outFileName ← "./examples/raylib/raylib.json"
apiDefine ← "RLAPI"       # Functions define (i.e. RLAPI for raylib.h)

json←•Import"json.bqn"

"
    This parser scans file.h to get API information about defines, structs, aliases, enums, callbacks and functions.
    All data is divided into pieces, usually as strings.

    CONSTRAINTS:

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
"

For ← {I‿C‿P‿A: I@ ⋄ C •_while_ P∘A@}

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
# int *hello

GetDataTypeAndName ← ⌈´∘⊐⟜"* "⊸(↑⋈↓) #‿type‿name: # const char *typeName, int typeNameLen, char *type, char *name)

# Get comment from a line, do nothing if no comment in line
GetDescription ← ∨`∘∧⟜«∘=⟜'/'⊸/ # str → description (str)

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
lines ← ' '⍟((9+@)⊸≡)¨¨ •FLines inFileName

defMacro ← "#define"
CheckHex ← ¬∨´∘=⟜"0123456789abcdefABCDEFxL.+-"

definesNonStripped ← {𝕊linePtr:
    type ← 0
    description ← ""
    ishex ← 0
    operand ← ""

    LS ← ∨`∘=⟜' ' # leading spacing
    nameAndArgs ← LS⊸/{𝔽defMacro∾⁼𝔽}linePtr # Skip spaces, then defMacro, then spaces again

    # Extract name
    defineNameStart ← linePtr-○≠nameAndArgs
    
    openBraces ← +`-˝"()"=⌜nameAndArgs
    
    nameLen ← defineNameEnd ← (⊐⟜' '≤·⊑⊐⟜'(')◶⟨
        1+⊐⟜')'
        ⊐⟜' '
    ⟩ nameAndArgs

    name‿args ← nameLen(↑⋈LS⊸/∘↓)nameAndArgs

    # Determine type
    {𝕊:type↩macro}⍟⊢')'=¯1⊑name
    {𝕊:type↩guard}⍟⊢(0=≠args)∨'/'=⊑args

    {'"'=⊑args? type↩string
    ;args=○⊑"'"? type↩char
    ;"CLITERAL(Color)"≡15↑args? type↩color
    ;⊑args⊑⊸∊'0'+↕10? # Parsing numbers
        m←∧`∘≠⟜' '⊸/args
        m2←∨`∘=⟜' '⊸/args
        isFloat  ← ⊑m∊'.'

        {⊑m∊'x'?
            {𝕊:ishex↩CheckHex m}⍟⊢isFloat

            # Found a valid number -> update type
            type⌈↩[
                int‿long
                double‿float
            ]⊑˜isFloat∾(isFloat⊑"Lf")=¯1⊑m2
        }
    ;@
    }

    # Extracting value
    fullValue ← ∨`⌾⌽∘≠⟜' '⊸/args/˜¬∨`0∾˜"//"⍷args
    value ← fullValue↓˜-⊑type∊long‿float # Remove number postfix

    # Extracting description
    desc ← GetDescription args

    # Parse defines of type UNKNOWN to find calculated numbers
    isMath ← 1
    {𝕤

        For (c←0)‿{𝕊:c<≠value}‿{𝕊:c+↩1}‿{𝕤
            # Skip operators and whitespace
            (∨´(c⊑value)="0123456789")∧¬∨´(c⊑value)="()+-*/ "?
                # Read number operand                
                m ← ∧`¬"()*/ "∊˜c↓value
                v ← m/c↓value
                h ← ∧`¬CheckHex¨v
                isNumber←∨´CheckHex¨v
                isFloat←∨´'.'=h/v
                c+↩isNumber++´h
                
                isMath ∧↩ isNumber
                
                {𝕤
                    # Found a valid number -> update largestType
                    type⌈↩[
                        INT_MATH‿LONG_MATH
                        DOUBLE_MATH‿FLOAT_MATH
                    ]⊑˜isFloat⋈(isFloat⊑"Lf")=value⊑˜c-1
                }⍟⊢isNumber
        ;
                # Read string operand
                operandStart ← c
                c+↩+´¬∨`" ()+-*/"∊˜c↓value
                operandEnd ← c

                # Search previous defines for operand
                operand ↩ operandStart↓operandEnd↑value
        }

    }⍟⊢type=unknown

    name‿type‿value‿description‿ishex‿operand‿isMath
}¨↓⟜lines¨/defMacro⊸(⊣≡≠⊸↑)¨∨`∘=⟜' '⊸/¨lines

# Skip duplicates
definesWithRefs ← (∊⊑¨)⊸/definesNonStripped

# solve refrences to previously defined defines
defines←{lastDefines𝕊name‿type‿value‿description‿ishex‿operand‿isMath:
    foundOperand ← ∨´{𝕊lastname‿lasttype‿lastvalue‿lastdescription‿lastishex‿lastoperand:
        ((≥⟜int∧≤⟜double_math) lastType)∧lastname ≡ operand?
            type ⌈↩ lastType
            1
    ;0
    }¨lastDefines

    isMath>↩foundOperand

    {𝕤
        # Define is a calculated number -> update type
        type {
            𝕩 = int    ? int_math
            𝕩 = long   ? long_math
            𝕩 = float  ? float_math
            𝕩 = double ? double_math
        }↩
    }⍟⊢isMath


    name‿type‿value‿description‿ishex‿operand
}{(¯1↓𝕩)𝔽¨¯1⊑𝕩}¨1↓↑definesWithRefs


# Structs info data
structs ← {𝕤
    linesPtr ← 𝕩↓lines

    # Parse struct description
    desc ← GetDescription (𝕩-1)⊑linesPtr

    # Get struct name: typedef struct name {
    name←' '⊸≠⊸/∧`∘≠⟜'{'⊸/"typedef struct "∾⁼⊑linesPtr

    # Get struct fields and count them -> fields finish with ;
    fields ← ⟨⟩∾´{
        fieldType‿fieldNamesUnparsed ← GetDataTypeAndName ⊐⟜';'⊸↑𝕩
        fieldNames←','((⊢-˜+`×¬)∘=⊔⊢)fieldNamesUnparsed
        fieldDesc ← GetDescription 𝕩

        # Move type len info from name to type
        fieldTypes ← {fieldType∾1↓¯1↓∨`∘=⟜'['⊸/𝕩}¨fieldnames
        fieldnames ∧`∘≠⟜'['⊸/¨↩

        (<fieldDesc)∾˘fieldTypes≍˘fieldNames
    }⍟((' '≠⊑)∧·∧´"struct"‿"/"≢¨6‿1↑¨<)¨(∧`'}'=·∾1⊸↑¨)⊸/1↓linesPtr

    name‿desc‿fields

    # Read struct lines
    # Find structs
    # starting with "typedef struct ... {" or "typedef struct ... ; \n struct ... {"
    # ending with "} ... ;"
    # i.e. excluding "typedef struct rAudioBuffer rAudioBuffer;" -> Typedef and forward declaration only
}¨/{
    [m1,m2]←"typedef struct"‿"struct"(⊣≡≠⊸↑)⌜𝕩
    m1∧m2«⊸∨<´∘⊐⟜"{;"¨𝕩
} lines


# Alias info data
aliases ← {𝕤
    linePtr ←𝕩⊑lines
    desc ← (lines⊑˜𝕩-1)⊣⍟(""⊸≡)○GetDescription linePtr
    type‿name ← ' '((¬-˜⊢×·+`»⊸>)∘≠⊔⊢)"typedef "∾⁼⊐⟜'/'⊸↑linePtr  
    type‿name‿desc
}¨/(∨´∘=⟜';'∧"typedef"⊸(⊣≡≠⊸↑)∧2=(+´' '⊸=>∨`∘=⟜';'))¨lines # Find aliases (lines with "typedef ... ...;")

enums ← {
    # Parse enum description
    # NOTE: This is not necessarily from the line immediately before,
    # some of the enums have extra lines between the "description"
    # and the typedef enum
    desc ← GetDescription ⊑(∧`("// "≡3⊸↑)¨)⊸/⌾⌽𝕩↑lines

    # Parse enum value line, possible options:
    #ENUM_VALUE_NAME,
    #ENUM_VALUE_NAME
    #ENUM_VALUE_NAME     = 99
    #ENUM_VALUE_NAME     = 99,
    #ENUM_VALUE_NAME     = 0x00000040,   # Value description
    values ← {𝕤
        valueInteger ← ⟨⟩

        # We start reading the value name
        valueName←(∧`∧˝", ="≠⌜⊢)⊸/𝕩

        # After the name we can have:
        #  '='  -> value is provided
        #  ','  -> value is equal to previous + 1, there could be a description if not '\0'
        #  ' '  -> value is equal to previous + 1, there could be a description if not '\0'
        #  '\0' -> value is equal to previous + 1

        # Let's start checking if the line is not finished
        # Two options:
        #  '='  -> value is provided
        #  ' '  -> value is equal to previous + 1, there could be a description if not '\0'
        
        valuesUnparsed←' '⊸≠⊸/valueName∾⁼⊏⟜'/'⊸↑𝕩

        value ← ('='=⊑)◶⟨@⋄•ParseFloat'='⊸∾⁼⟩valuesUnparsed

        # Parse value description
        valueDesc ← GetDescription 𝕩

        valueName‿value‿valueDesc
    }¨(≥⟜'A'∧'Z'⊸≥)∘⊑¨⊸/ ∨`∘≠⟜' '⊸/¨(lines↓˜1+𝕩)/˜m←∧`'}'≠⊑¨lines↓˜1+𝕩
    
    values {𝕩=@?𝕨+1;𝕩}`⌾(1⊸⊑)¨↩

    # Get enum name from typedef
    name←"} "∾⁼⊏⟜';'⊸↑lines⊑˜1+𝕩

    name‿desc‿values

    # Read enum lines
    # ignore inline enums
}¨ /("typedef enum {"⊸(⊣≡≠⊸↑)∧∨´∘=⟜';')¨lines

callbacks ← {
    RLS ← ∨`∘≠⟜' '⊸/
    
    # Return type
    afterDef ← RLS "typedef "∾⁼𝕩
    retType ← RLS⌾⌽ ⊐⟜'('⊸↑afterDef
    afterStar ← RLS "(*"∾⁼ RLS retType∾⁼RLS afterDef
    name ← RLS⌾⌽ ⊐⟜')'⊸↑ afterStar
    afterName ← RLS")("∾⁼RLS name∾⁼afterStar

    # ⟨paramType‿paramName, ...⟩
    [paramTypes,paramNames] ← ⍉>GetDataTypeAndName¨ ','((⊢-˜+`×¬)∘=⊔⊢) ⊐⟜')'⊸↑afterName

    # Move array sizes from name to type
    paramTypes∾¨↩⊐⟜'['⊸↓¨paramNames
    paramNames ⊐⟜'['⊸↓↩

    # Description
    desc ← GetDescription 𝕩

    paramCount←≠paramNames
    name‿desc‿retType‿paramTypes‿paramNames
}¨{
    # Read callback lines
    # Find callbacks (lines with "typedef ... (* ... )( ... );")
    m1←"typedef"⊸(⊣≡≠⊸↑)¨𝕩
    m1∧{((∨´");"⊸≡˘)<(∨´")("⊸≡˘)∧(∨´"(*"⊸≡˘))2↕" "⍟(""⊸≡)𝕩}¨𝕩
}⊸/lines

funcs←{
    funcSignature ← 𝕩∾⁼˜apiDefine∾' '

    retType‿name ← GetDataTypeAndName ⊐⟜'('⊸↑funcSignature

    [paramTypes⋄paramNames]←⟨⟩⊸≢◶⟨↕2‿0⋄⍉>⟩("void"≢¯4⊸↑)◶⟨
        ⟨⟩ ⋄ {GetDataTypeAndName¨(∨`∧∨⟜«)∘≠⟜' '⊸/¨','((⊢-˜+`×¬)∘=⊔⊢)𝕩}
    ⟩ ⊐⟜')'⊸↑(1+⊐⟜'(')⊸↓funcSignature

    # Move array sizes from name to type
    paramTypes∾¨↩⊐⟜'['⊸↓¨paramNames
    paramNames ⊐⟜'['⊸↑¨↩

    desc ← GetDescription 𝕩

    name‿desc‿retType‿paramNames‿paramTypes

    # Read function lines
    # Read function line (starting with `define`)
}¨apiDefine⊸(⊣≡≠⊸↑)¨⊸/lines

•Out"Input file:  "∾inFileName
•Out"Output file: "∾outFileName

EscapeBackslashes←∾'\'⊸=◶⋈‿"//"¨
# Export parsed data in json
parsedData ← ∾⟨
    ⋈"{"

    # Print defines info
    ⋈"  ""defines"": ["
    ¯1⊸↓⌾(¯1⊸⊑)⍟(⟨⟩⊸≢)∾{𝕊name‿type‿value‿description‿ishex‿operand:∾⟨
        ⋈"    {"
        ⋈"      ""name"": """∾name∾""","
        ⋈"      ""type"": """∾(StrDefineType type)∾""","
        {isHex? # INT or LONG
            "      ""value"": "∾(16⊸×⊸+˜´⌽value⊐˜∾"0A"+⟜↕¨10‿6)∾","
        ;∨´type = INT‿LONG‿FLOAT‿DOUBLE‿STRING?
            "      ""value"": "∾value∾','
        ;
            "      ""value"": """∾value∾""","
        }
        ⋈"      ""description"": """∾description∾""""
        ⋈"    },"
    ⟩}¨defines
    ⋈"  ],"
    # Print structs info
    ⋈"  ""structs"": ["
    ¯1⊸↓⌾(¯1⊸⊑)⍟(⟨⟩⊸≢)∾{𝕊name‿desc‿fields:⟨
        ⋈"    {"
        ⋈"      ""name"": """∾name∾""","
        ⋈"      ""description"": """∾(EscapeBackslashes desc)∾""","
        ⋈"      ""fields"": ["
        ∾¯1⊸↓⌾(¯1⊸⊑)⍟(⟨⟩⊸≢){𝕊fieldDesc‿fieldType‿fieldName:⟨
            "        {"
            "          ""type"": """∾fieldType∾""","
            "          ""name"": """∾fieldName∾""","
            "          ""description"": """∾(EscapeBackslashes fieldDesc)∾""""
            "        },"
        ⟩}¨<˘fields

        ⋈"      ]"
        ⋈"    },"
    ⟩}¨structs
    ⋈"  ],"

    # Print aliases info
    ⋈"  ""aliases"": ["
    ¯1⊸↓⌾(¯1⊸⊑)⍟(⟨⟩⊸≢)∾{𝕊type‿name‿desc:⟨
        "    {"
        "      ""type"": """∾type∾""","
        "      ""name"": """∾name∾""","
        "      ""description"": """∾desc∾'"'
        "    },"
    ⟩}¨aliases
    ⋈"  ],"

    # Print enums info
    ⋈"  ""enums"": ["
    ¯1⊸↓⌾(¯1⊸⊑)⍟(⟨⟩⊸≢)∾{𝕊name‿desc‿values:
        ∾⟨
            ⋈"    {"
            ⋈"      ""name"": """∾name∾""","
            ⋈"      ""description"": """∾(EscapeBackslashes desc)∾""","
            ⋈"      ""values"": ["
            ¯1⊸↓⌾(¯1⊸⊑)⍟(⟨⟩⊸≢)∾{𝕊valueName‿value‿valueDesc:
                ⟨
                    "        {"
                    "          ""name"": """∾valueName∾""","
                    "          ""value"": "∾value∾","
                    "          ""description"": """∾(EscapeBackslashes valueDesc)∾'"'
                    "        },"
                ⟩
            }¨values
            ⋈"      ]"
            ⋈"    },"
        ⟩
    }¨enums
    ⋈"  ],"

    # Print callbacks info
    ⋈"  ""callbacks"": ["
    ¯1⊸↓⌾(¯1⊸⊑)⍟(⟨⟩⊸≢)∾{𝕊name‿desc‿retType‿paramTypes‿paramNames:∾⟨
        ⋈"    {"
        ⋈"      ""name"": """∾name∾""","
        ⋈"      ""description"": """∾(EscapeBackslashes desc)∾""",",
        ⋈"      ""returnType"": """∾retType∾""","
        ⋈"      ""params"": ["
        ¯1⊸↓⌾(¯1⊸⊑)⍟(⟨⟩⊸≢)∾paramTypes{𝕊p:
            "        {"
            "          ""type"": """∾𝕨∾"""," 
            "          ""name"": """∾𝕩∾""""  
            "        },"
        }¨paramNames
        ⋈"      ]"
        ⋈"    },"
    ⟩}¨callbacks
    ⋈"  ],"

    # Print functions info
    ⋈"  ""functions"": ["
    ¯1⊸↓⌾(¯1⊸⊑)⍟(⟨⟩⊸≢)∾{𝕊name‿desc‿retType‿paramNames‿paramTypes: 
        ∾⟨
            ⋈"    {"
            ⋈"      ""name"": """∾name∾""","
            ⋈"      ""description"": """∾(EscapeBackslashes desc)∾""","
            ⋈"      ""returnType"": """∾retType∾""","
            ∾⟨
                ⋈"      ""params"": ["
                ∾paramTypes{
                    ⟨
                        "        {"
                        "          ""type"": """∾𝕨∾""","
                        "          ""name"": """∾𝕩∾'"'
                        "        }"
                        ","
                    ⟩
                }¨paramNames
                ⋈"      ]"
            ⟩
            ⋈"    },"
        ⟩
    }¨funcs

    ⋈"  ]"
    ⋈"}"
⟩

outFileName •FLines •SHow¨ parsedData