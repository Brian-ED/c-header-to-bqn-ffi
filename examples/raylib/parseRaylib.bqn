#!/usr/bin/env bqn
⟨JsonToFFI⋄HeaderToJson⋄ToPrettyJson⟩ ← •Import "../../parse.bqn"
json ← •Import "../../json.bqn"

inp ← •FChars "raylib.h"

top ← "
⟨raylibPath⟩ ← •Import ""src/loadConfig.bqn""
r ⇐ MakeImporter raylibPath

"

"raylib.bqn" •FChars top∾JsonToFFI json.Parse ToPrettyJson "RLAPI" HeaderToJson inp

•Out "raylib.bqn successfully generated"