#!/usr/bin/env bqn
⟨HeaderToFFI⋄SetPath⟩ ← •Import "../../parse.bqn"
"output-exotic.bqn" •FChars "somePath" SetPath "RLAPI" HeaderToFFI •FChars "exotic.h"
•Out "output-exotic.bqn successfully generated"
