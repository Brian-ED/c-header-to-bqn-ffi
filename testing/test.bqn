# LINUX ONLY: tests intended only to be run on linux with cc as the c compiler

•Out "Finding examples to test"
examplesDir ← "../examples"
exampleFiles ← (•file.List∾¨˜⟜<'/'∾˜⊢){∾𝔽¨𝔽𝕩} examplesDir
testFiles ← "raymath.bqn"⊸(⊣≢-∘≠⊸↑)¨⊸/ ("parse"⊸(⊣≡≠⊸↑)∧".bqn"⊸(⊣≡-∘≠⊸↑))∘(∧`⌾⌽∘≠⟜'/'⊸/)¨⊸/exampleFiles

outputFailedJSONFiles ← 0

SH ← {exitcode‿stdout‿stderr←•SH𝕩
  •term.OutRaw stdout
  stderr!0=exitcode
}

{
  ##################################
  # Test the output files changing #
  ##################################

  •Out "Testing "∾𝕩
  •term.OutRaw "    "
  path ← ∨`⌾⌽∘=⟜'/'⊸/𝕩
  headerPath ← ⊑".h"⊸(⊣≡-∘≠⊸↑)¨⊸/(<∾¨•file.List)path
  outputPath ← ⊑{("output-"⊸(⊣≡≠⊸↑)∧".bqn"⊸(⊣≡-∘≠⊸↑))¨•file.Name¨𝕩}⊸/(<∾¨•file.List)path
  bqnParserPath ← ⊑{("parse-"⊸(⊣≡≠⊸↑)∧".bqn"⊸(⊣≡-∘≠⊸↑))¨•file.Name¨𝕩}⊸/(<∾¨•file.List)path

  beforeParse ← •FChars outputPath
  ⟨⟩ •Import 𝕩
  afterParse ← •FChars outputPath
  outputPath •FChars beforeParse # so the output file is uneffected by testing
  !afterParse≡beforeParse
}¨testFiles

# compile c parser
parserPath ← "./raylib_parser.c"
binLocation ← "/tmp/a.out"

•Out ""
•Out "Attempting to compile raylib_parser.c to compare outputs"
•Out ""
SH "cc"‿parserPath‿"-o"‿binLocation


ParseHeader‿ToPrettyJson ← •Import "../parse.bqn"
json ← •Import "../json.bqn"

raylibOutputTestcases ← {𝕊pathToFile:
  path ← ∨`⌾⌽∘=⟜'/'⊸/pathToFile
  headerPath ← ⊑".h"⊸(⊣≡-∘≠⊸↑)¨⊸/(<∾¨•file.List)path
  outputPath ← ⊑{("output-"⊸(⊣≡≠⊸↑)∧".bqn"⊸(⊣≡-∘≠⊸↑))¨•file.Name¨𝕩}⊸/(<∾¨•file.List)path
  bqnParserPath ← ⊑{("parse-"⊸(⊣≡≠⊸↑)∧".bqn"⊸(⊣≡-∘≠⊸↑))¨•file.Name¨𝕩}⊸/(<∾¨•file.List)path

  raylibJsonTempLoc ← "/tmp/temp.json"
  tmpHeaderPath ← "/tmp/temp.h"

  #########################
  # Test the json outputs #
  #########################
  tmpHeaderPath •FChars •FChars headerPath

  •Out "Parsing "∾headerPath∾" with raylib_parser.c and parse.bqn"
  SH binLocation‿"-i"‿tmpHeaderPath‿"-o"‿raylibJsonTempLoc‿"-d"‿"RLAPI"
  cMadeJson ← •FChars raylibJsonTempLoc
  bqnMadeJson ← (@+10)∾˜ToPrettyJson "RLAPI" ParseHeader •FChars headerPath
  •Out "Parsing successful"

  correct ← cMadeJson ≡ bqnMadeJson
  •Out "testcase "∾headerPath∾correct⊑" failed"‿" succeded"
  {𝕊:"c.json"‿"bqn.json" •FChars¨ cMadeJson‿bqnMadeJson}⍟¬correct
  {𝕤
    name ← ∧`∘≠⟜'.'⊸/∧`⌾⌽∘≠⟜'/'⊸/pathToFile
    cLoc ← name∾"C.json"
    bqnLoc ← name∾"BQN.json"
    •Out "Outputting files as "∾cLoc∾" and "∾bqnLoc
    cLoc •FChars cMadeJson
    bqnLoc •FChars bqnMadeJson
  }⍟⊢correct¬⊸∧outputFailedJSONFiles
  •Out ""
}¨testFiles