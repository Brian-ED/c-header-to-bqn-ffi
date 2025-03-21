#!/usr/bin/env bqn
⟨HeaderToFFI⋄ParseHeader⟩ ← •Import "../../parse.bqn"
"output-raymath.bqn" •FChars "RMAPI" HeaderToFFI •FChars "raymath.h"
•Out "output-raylib.bqn successfully generated"
