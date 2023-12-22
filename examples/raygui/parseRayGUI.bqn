#!/usr/bin/env bqn
inp ← (⊢↑˜91-˜1⊐˜"RAYGUI IMPLEMENTATION"⊸⍷) •FChars "raygui.h"
t←⟨inp⟩ •Import"../../parse.bqn"

"raygui.bqn"•FChars t
•Out "raygui.bqn successfully generated"
