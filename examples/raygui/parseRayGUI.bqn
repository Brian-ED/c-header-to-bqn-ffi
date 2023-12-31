#!/usr/bin/env bqn
⟨JsonToFFI⋄ParseHeader⋄ToPrettyJson⟩ ← •Import "../../parse.bqn"
json ← •Import "../../json.bqn"

inp ← •FChars "raygui.h"

"raygui.bqn" •FChars JsonToFFI json.Parse ToPrettyJson ParseHeader inp

•Out "raygui.bqn successfully generated"
