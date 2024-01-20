#!/usr/bin/env bqn
⟨HeaderToFFI⟩ ← •Import "../../parse.bqn"
"output-rlgl.bqn" •FChars "RLAPI" HeaderToFFI •FChars "rlgl.h"
•Out "output-rlgl.bqn successfully generated"