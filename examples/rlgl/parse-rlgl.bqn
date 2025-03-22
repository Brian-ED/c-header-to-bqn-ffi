#!/usr/bin/env bqn
⟨ToFFI⋄ParseHeader⋄SetPath⟩ ← •Import "../../parse.bqn"
map ← [
  "RL_ZERO"‿"RLGL_VERSION"
  "RLZERO" ‿"RLGLVersionString"
]
ffi ← •path SetPath map ToFFI "RLAPI" ParseHeader •FChars "rlgl.h"
"output-rlgl.bqn" •FChars ffi
•Out "output-rlgl.bqn successfully generated"
