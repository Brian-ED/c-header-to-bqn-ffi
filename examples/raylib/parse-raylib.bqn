#!/usr/bin/env bqn
⟨HeaderToFFI⟩ ← •Import "../../parse.bqn"
"output-raylib.bqn" •FChars "RLAPI" HeaderToFFI •FChars "raylib.h"
•Out "output-raylib.bqn successfully generated"
