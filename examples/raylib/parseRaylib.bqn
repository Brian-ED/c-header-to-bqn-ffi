#!/usr/bin/env bqn
parsed ← ⟨•FChars "raylib.h"⋄"RLAPI"⟩•Import "../../parse.bqn"
top ← "
⟨raylibPath⟩ ← •Import ""src/loadConfig.bqn""
r ⇐ MakeImporter raylibPath
⟩"

"raylib.bqn" •FChars top∾parsed

•Out "raylib.bqn successfully generated"