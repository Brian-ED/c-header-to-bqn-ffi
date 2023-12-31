#!/usr/bin/env bqn
⟨JsonToFFI⋄ParseHeader⋄ToPrettyJson⟩ ← •Import "../../parse.bqn"
json ← •Import "../../json.bqn"

inp ← •FChars "raylib.h"

"output-raylib.bqn" •FChars JsonToFFI json.Parse ToPrettyJson "RLAPI" ParseHeader inp

•Out "raylib.bqn successfully generated"