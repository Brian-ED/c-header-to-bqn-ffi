#!/usr/bin/env bqn
⟨JsonToFFI⋄HeaderToJson⋄ToPrettyJson⟩ ← •Import "../../parse.bqn"
json ← •Import "../../json.bqn"

inp ← (¯91+1⊐˜"RAYGUI IMPLEMENTATION"⊸⍷)⊸↑ •FChars "raygui.h"

"raygui.bqn" •FChars JsonToFFI json.Parse ToPrettyJson HeaderToJson inp

•Out "raygui.bqn successfully generated"
