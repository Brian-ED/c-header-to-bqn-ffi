#!/usr/bin/env bqn
HeaderToFFI‿SetPathResolving ← •Import "../../parse.bqn"
resolver←¯1↓1↓"
⊑•args⍟(0=≠)⟨
  #INSERT-CUSTOM-RAYLIB-PATH-HERE
⟩
"
"output-raylib.bqn" •FChars resolver SetPathResolving "RLAPI" HeaderToFFI •FChars "raylib.h"
•Out "output-raylib.bqn successfully generated"
