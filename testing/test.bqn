# LINUX ONLY: tests intended only to be run on linux with cc as the c compiler

•Out "Finding examples to test"
examplesDir ← "../examples"
exampleFiles ← (•file.List∾¨˜⟜<'/'∾˜⊢){∾𝔽¨𝔽𝕩} examplesDir
testFiles ← ("parse"⊸(⊣≡≠⊸↑)∧".bqn"⊸(⊣≡-∘≠⊸↑))∘(∧`⌾⌽∘≠⟜'/'⊸/)¨⊸/exampleFiles

outputFailedJSONFiles ← 0

SH ← {exitcode‿stdout‿stderr←•SH𝕩
  •term.OutRaw stdout
  stderr!0=exitcode
}

{
  •Out "Testing "∾𝕩
  •term.OutRaw "    "
  •Import 𝕩
}¨testFiles

# compile c parser
parserPath ← "./raylib_parser.c"
binLocation ← "/tmp/a.out"

•Out ""
•Out "Attempting to compile raylib_parser.c to compare outputs"
•Out ""
SH "cc"‿parserPath‿"-o"‿binLocation


⟨JsonToFFI⋄ParseHeader⋄ToPrettyJson⟩ ← •Import "../parse.bqn"
json ← •Import "../json.bqn"

raylibOutputTestcases ← {𝕊pathToFile:
  path ← ∨`⌾⌽∘=⟜'/'⊸/pathToFile
  headerPath ← ⊑".h"⊸(⊣≡-∘≠⊸↑)¨⊸/(<∾¨•file.List)path
  
  raylibJsonTempLoc ← "temp.json"
  tmpHeaderPath ← "temp.h"
  
  tmpHeaderPath •FChars •FChars headerPath
  raylibJsonTempLoc •FChars ""
  •Out "Parsing "∾headerPath∾" with raylib_parser.c and parse.bqn"
  SH binLocation‿"-i"‿tmpHeaderPath‿"-o"‿raylibJsonTempLoc‿"-d"‿"RLAPI"
  •file.Remove tmpHeaderPath
  cMadeJson ← •FChars raylibJsonTempLoc
  •file.Remove raylibJsonTempLoc
  bqnMadeJson ← (@+10)∾˜ToPrettyJson "RLAPI" ParseHeader •FChars headerPath
  •Out "Parsing successful"
  correct ← cMadeJson ≡ bqnMadeJson
  •Out "testcase "∾headerPath∾correct⊑" failed"‿" succeded"
  {𝕤
    name← ∧`∘≠⟜'.'⊸/∧`⌾⌽∘≠⟜'/'⊸/pathToFile
    cLoc ← name∾"C.json"
    bqnLoc ← name∾"BQN.json"
    •Out "Outputting files as "∾cLoc∾" and "∾bqnLoc
    cLoc •FChars cMadeJson
    bqnLoc •FChars bqnMadeJson
  }⍟⊢correct∧outputFailedJSONFiles
  •Out ""
}¨testFiles

•file.Remove binLocation
