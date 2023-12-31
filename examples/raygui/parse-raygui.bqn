#!/usr/bin/env bqn
⟨HeaderToFFI⟩ ← •Import "../../parse.bqn"
"output-raygui.bqn" •FChars HeaderToFFI •FChars "raygui.h"
•Out "raygui.bqn successfully generated"