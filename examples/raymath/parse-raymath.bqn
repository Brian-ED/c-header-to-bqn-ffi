#!/usr/bin/env bqn
⟨HeaderToFFI⋄ParseHeader⋄ToPrettyJson⟩ ← •Import "../../parse.bqn"
"output-raymath.json" •FChars ToPrettyJson "RMAPI" ParseHeader •FChars "raymath.h"
"output-raymath.bqn" •FChars "RMAPI" HeaderToFFI •FChars "raymath.h"
•Out "output-raylib.bqn successfully generated"
