#!/usr/bin/env bqn
HeaderToFFI‿SetPathResolver ← •Import "../../parse.bqn"
resolver←¯1↓1↓"
⊑•args⍟(0=≠)⟨
  #INSERT-CUSTOM-RAYLIB-PATH-HERE
⟩
"
"output-raylib.bqn" •FChars resolver SetPathResolver "RLAPI" HeaderToFFI •FChars "raylib.h"
•Out "output-raylib.bqn successfully generated"
