#!/usr/bin/env bqn
⟨HeaderToFFI⟩ ← •Import "../../parse.bqn"
"output-raygui.bqn" •FChars "RAYGUIAPI" HeaderToFFI •FChars "raygui.h"
•Out "output-raygui.bqn successfully generated"
