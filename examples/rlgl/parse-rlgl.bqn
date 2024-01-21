#!/usr/bin/env bqn
⟨ToFFI⋄ParseHeader⟩ ← •Import "../../parse.bqn"
map ← [
  "RL_ZERO"‿"RLGL_VERSION"
  "RLZERO" ‿"RLGLVersionString"
]
ffi ← map ToFFI "RLAPI" ParseHeader •FChars "rlgl.h"
ffiSplit ← (⊐⟜1"⊑•args"⍷ffi)(↑⋈(≠"⊑•args")↓↓)ffi
ffiWithPath ← (⊣∾""""∾•path∾""""∾⊢)´ffiSplit
"output-rlgl.bqn" •FChars ffiWithPath
•Out "output-rlgl.bqn successfully generated"