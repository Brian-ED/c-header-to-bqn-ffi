#!/usr/bin/env bqn
⟨HeaderToFFI⟩ ← •Import "../../parse.bqn"
"output-raygui.bqn" •FChars "RAYGUIAPI" HeaderToFFI •FChars "raygui.h"
•Out "raygui.bqn successfully generated"