#### THIS TEXT HAS BEEN AUTOGENERATED ####

# Makes an importer that improves the ffi function creation syntax
MakeImporter ⇐ {debug𝕊pathToBin: # Debug is useful for Segmentation Faults
  NestedStructToStr ← {
    1≥≡𝕩?𝕩;
    lists‿atoms ← ×∘≡¨⊸(/ ⋈ ¬⊸/)𝕩
    atoms∾'{'∾'}'«∾','∾¨𝕊¨lists
  }
  NestedStructToStrRet ← {
    1≥≡𝕩?𝕩;
    lists‿atoms ← ×∘≡¨⊸(/ ⋈ ¬⊸/)𝕩
    atoms∾'{'∾'}'«∾','∾¨𝕊¨"*"⍟("*i8:c8"⊸≡∨"*u8:c8"⊸≡)¨lists
  }

  {𝕨 funcName _𝕣 inpTypes: outType←𝕨⊣⟨⟩
    a←'>'⊸∾⌾⊑⍟(1=≠) NestedStructToStr¨𝕩
    HandleError ← {
      •Out "DEBUG TYPE INFO:"
      •Out •Fmt 𝕩
      •Out "END OF DEBUG TYPE INFO; BEGINING WITH FULL ERROR:"
      •term.Flush@
      𝕨•FFI𝕩
    }
    func ← pathToBin •FFI⎊HandleError ⟨ NestedStructToStrRet outType⋄funcName⟩∾a
    m ← str⊸≡¨a
    IfDebug ← {•term.Flush@⊣•Out funcName ⋄ 𝕏⊣•term.Flush∘@⊣•Out∘funcName}
    IfDebug⍟debug {𝕏∾⟜@}⍟(a≡⋈'>'∾str) {𝕏∾⟜@¨⌾(m⊸/)}⍟(∨´m) func
  }
}

# predefined C types
bool ⇐ "i8"
c    ⇐ "i8"
i    ⇐ "i32"
f    ⇐ "f32"
u    ⇐ "u32"
i8   ⇐ "i8"
u8   ⇐ "u8"
str  ⇐ "*i8:c8"
uStr ⇐ "*u8:c8"
ptr  ⇐ "*"

pathToBinary ⇐ ⊑•args
r ⇐ 0 MakeImporter pathToBinary

##################################
# End of setup for easy ffi.     #
# Begining of autogenerated ffi. #
##################################

pI      ⇐ 3.141592653589793 #
ePSILON ⇐ 1e¯6              #


v2 ⇐ ⟨ # Vector2 type
  f # x  #
  f # y  #
⟩
v3 ⇐ ⟨ # Vector3 type
  f # x  #
  f # y  #
  f # z  #
⟩
v4 ⇐ ⟨ # Vector4 type
  f # x  #
  f # y  #
  f # z  #
  f # w  #
⟩
quaternion ⇐ v4 # Quaternion type
matrix ⇐ ⟨ # Matrix type (OpenGL style 4x4 - right handed, column major)
  f # m0   # Matrix first row (4 components)
  f # m4   # Matrix first row (4 components)
  f # m8   # Matrix first row (4 components)
  f # m12  # Matrix first row (4 components)
  f # m1   # Matrix second row (4 components)
  f # m5   # Matrix second row (4 components)
  f # m9   # Matrix second row (4 components)
  f # m13  # Matrix second row (4 components)
  f # m2   # Matrix third row (4 components)
  f # m6   # Matrix third row (4 components)
  f # m10  # Matrix third row (4 components)
  f # m14  # Matrix third row (4 components)
  f # m3   # Matrix fourth row (4 components)
  f # m7   # Matrix fourth row (4 components)
  f # m11  # Matrix fourth row (4 components)
  f # m15  # Matrix fourth row (4 components)
⟩
float3 ⇐ ⟨ # NOTE: Helper types to be used instead of array return types for *ToFloat functions
  "[3]"∾f # v  #
⟩
float16 ⇐ ⟨ #
  "[16]"∾f # v  #
⟩

clamp                          ⇐ f         "Clamp"                          _R⟨f⋄f⋄f⟩                                        # value min max                                   #
lerp                           ⇐ f         "Lerp"                           _R⟨f⋄f⋄f⟩                                        # start end amount                                #
normalize                      ⇐ f         "Normalize"                      _R⟨f⋄f⋄f⟩                                        # value start end                                 #
remap                          ⇐ f         "Remap"                          _R⟨f⋄f⋄f⋄f⋄f⟩                                    # value inputStart inputEnd outputStart outputEnd #
wrap                           ⇐ f         "Wrap"                           _R⟨f⋄f⋄f⟩                                        # value min max                                   #
floatEquals                    ⇐ i         "FloatEquals"                    _R⟨f⋄f⟩                                          # x y                                             #
vector2Zero                    ⇐ v2        "Vector2Zero"                    _R⟨⟩                                             #                                                 #
vector2One                     ⇐ v2        "Vector2One"                     _R⟨⟩                                             #                                                 #
vector2Add                     ⇐ v2        "Vector2Add"                     _R⟨v2⋄v2⟩                                        # v1 v2                                           #
vector2AddValue                ⇐ v2        "Vector2AddValue"                _R⟨v2⋄f⟩                                         # v add                                           #
vector2Subtract                ⇐ v2        "Vector2Subtract"                _R⟨v2⋄v2⟩                                        # v1 v2                                           #
vector2SubtractValue           ⇐ v2        "Vector2SubtractValue"           _R⟨v2⋄f⟩                                         # v sub                                           #
vector2Length                  ⇐ f         "Vector2Length"                  _R⟨v2⟩                                           # v                                               #
vector2LengthSqr               ⇐ f         "Vector2LengthSqr"               _R⟨v2⟩                                           # v                                               #
vector2DotProduct              ⇐ f         "Vector2DotProduct"              _R⟨v2⋄v2⟩                                        # v1 v2                                           #
vector2Distance                ⇐ f         "Vector2Distance"                _R⟨v2⋄v2⟩                                        # v1 v2                                           #
vector2DistanceSqr             ⇐ f         "Vector2DistanceSqr"             _R⟨v2⋄v2⟩                                        # v1 v2                                           #
vector2Angle                   ⇐ f         "Vector2Angle"                   _R⟨v2⋄v2⟩                                        # v1 v2                                           #
vector2LineAngle               ⇐ f         "Vector2LineAngle"               _R⟨v2⋄v2⟩                                        # start end                                       #
vector2Scale                   ⇐ v2        "Vector2Scale"                   _R⟨v2⋄f⟩                                         # v scale                                         #
vector2Multiply                ⇐ v2        "Vector2Multiply"                _R⟨v2⋄v2⟩                                        # v1 v2                                           #
vector2Negate                  ⇐ v2        "Vector2Negate"                  _R⟨v2⟩                                           # v                                               #
vector2Divide                  ⇐ v2        "Vector2Divide"                  _R⟨v2⋄v2⟩                                        # v1 v2                                           #
vector2Normalize               ⇐ v2        "Vector2Normalize"               _R⟨v2⟩                                           # v                                               #
vector2Transform               ⇐ v2        "Vector2Transform"               _R⟨v2⋄matrix⟩                                    # v mat                                           #
vector2Lerp                    ⇐ v2        "Vector2Lerp"                    _R⟨v2⋄v2⋄f⟩                                      # v1 v2 amount                                    #
vector2Reflect                 ⇐ v2        "Vector2Reflect"                 _R⟨v2⋄v2⟩                                        # v normal                                        #
vector2Min                     ⇐ v2        "Vector2Min"                     _R⟨v2⋄v2⟩                                        # v1 v2                                           #
vector2Max                     ⇐ v2        "Vector2Max"                     _R⟨v2⋄v2⟩                                        # v1 v2                                           #
vector2Rotate                  ⇐ v2        "Vector2Rotate"                  _R⟨v2⋄f⟩                                         # v angle                                         #
vector2MoveTowards             ⇐ v2        "Vector2MoveTowards"             _R⟨v2⋄v2⋄f⟩                                      # v target maxDistance                            #
vector2Invert                  ⇐ v2        "Vector2Invert"                  _R⟨v2⟩                                           # v                                               #
vector2Clamp                   ⇐ v2        "Vector2Clamp"                   _R⟨v2⋄v2⋄v2⟩                                     # v min max                                       #
vector2ClampValue              ⇐ v2        "Vector2ClampValue"              _R⟨v2⋄f⋄f⟩                                       # v min max                                       #
vector2Equals                  ⇐ i         "Vector2Equals"                  _R⟨v2⋄v2⟩                                        # p q                                             #
vector2Refract                 ⇐ v2        "Vector2Refract"                 _R⟨v2⋄v2⋄f⟩                                      # v n r                                           #
vector3Zero                    ⇐ v3        "Vector3Zero"                    _R⟨⟩                                             #                                                 #
vector3One                     ⇐ v3        "Vector3One"                     _R⟨⟩                                             #                                                 #
vector3Add                     ⇐ v3        "Vector3Add"                     _R⟨v3⋄v3⟩                                        # v1 v2                                           #
vector3AddValue                ⇐ v3        "Vector3AddValue"                _R⟨v3⋄f⟩                                         # v add                                           #
vector3Subtract                ⇐ v3        "Vector3Subtract"                _R⟨v3⋄v3⟩                                        # v1 v2                                           #
vector3SubtractValue           ⇐ v3        "Vector3SubtractValue"           _R⟨v3⋄f⟩                                         # v sub                                           #
vector3Scale                   ⇐ v3        "Vector3Scale"                   _R⟨v3⋄f⟩                                         # v scalar                                        #
vector3Multiply                ⇐ v3        "Vector3Multiply"                _R⟨v3⋄v3⟩                                        # v1 v2                                           #
vector3CrossProduct            ⇐ v3        "Vector3CrossProduct"            _R⟨v3⋄v3⟩                                        # v1 v2                                           #
vector3Perpendicular           ⇐ v3        "Vector3Perpendicular"           _R⟨v3⟩                                           # v                                               #
vector3Length                  ⇐ f         "Vector3Length"                  _R⟨v3⟩                                           # v                                               #
vector3LengthSqr               ⇐ f         "Vector3LengthSqr"               _R⟨v3⟩                                           # v                                               #
vector3DotProduct              ⇐ f         "Vector3DotProduct"              _R⟨v3⋄v3⟩                                        # v1 v2                                           #
vector3Distance                ⇐ f         "Vector3Distance"                _R⟨v3⋄v3⟩                                        # v1 v2                                           #
vector3DistanceSqr             ⇐ f         "Vector3DistanceSqr"             _R⟨v3⋄v3⟩                                        # v1 v2                                           #
vector3Angle                   ⇐ f         "Vector3Angle"                   _R⟨v3⋄v3⟩                                        # v1 v2                                           #
vector3Negate                  ⇐ v3        "Vector3Negate"                  _R⟨v3⟩                                           # v                                               #
vector3Divide                  ⇐ v3        "Vector3Divide"                  _R⟨v3⋄v3⟩                                        # v1 v2                                           #
vector3Normalize               ⇐ v3        "Vector3Normalize"               _R⟨v3⟩                                           # v                                               #
vector3Project                 ⇐ v3        "Vector3Project"                 _R⟨v3⋄v3⟩                                        # v1 v2                                           #
vector3Reject                  ⇐ v3        "Vector3Reject"                  _R⟨v3⋄v3⟩                                        # v1 v2                                           #
vector3OrthoNormalize          ⇐           "Vector3OrthoNormalize"          _R⟨"*"∾v3⋄"*"∾v3⟩                                # v1 v2                                           #
vector3OrthoNormalizeRef       ⇐           "Vector3OrthoNormalize"          _R⟨"&"∾v3⋄"&"∾v3⟩                                # v1 v2                                           #
vector3Transform               ⇐ v3        "Vector3Transform"               _R⟨v3⋄matrix⟩                                    # v mat                                           #
vector3RotateByQuaternion      ⇐ v3        "Vector3RotateByQuaternion"      _R⟨v3⋄quaternion⟩                                # v q                                             #
vector3RotateByAxisAngle       ⇐ v3        "Vector3RotateByAxisAngle"       _R⟨v3⋄v3⋄f⟩                                      # v axis angle                                    #
vector3MoveTowards             ⇐ v3        "Vector3MoveTowards"             _R⟨v3⋄v3⋄f⟩                                      # v target maxDistance                            #
vector3Lerp                    ⇐ v3        "Vector3Lerp"                    _R⟨v3⋄v3⋄f⟩                                      # v1 v2 amount                                    #
vector3CubicHermite            ⇐ v3        "Vector3CubicHermite"            _R⟨v3⋄v3⋄v3⋄v3⋄f⟩                                # v1 tangent1 v2 tangent2 amount                  #
vector3Reflect                 ⇐ v3        "Vector3Reflect"                 _R⟨v3⋄v3⟩                                        # v normal                                        #
vector3Min                     ⇐ v3        "Vector3Min"                     _R⟨v3⋄v3⟩                                        # v1 v2                                           #
vector3Max                     ⇐ v3        "Vector3Max"                     _R⟨v3⋄v3⟩                                        # v1 v2                                           #
vector3Barycenter              ⇐ v3        "Vector3Barycenter"              _R⟨v3⋄v3⋄v3⋄v3⟩                                  # p a b c                                         #
vector3Unproject               ⇐ v3        "Vector3Unproject"               _R⟨v3⋄matrix⋄matrix⟩                             # source projection view                          #
vector3ToFloatV                ⇐ float3    "Vector3ToFloatV"                _R⟨v3⟩                                           # v                                               #
vector3Invert                  ⇐ v3        "Vector3Invert"                  _R⟨v3⟩                                           # v                                               #
vector3Clamp                   ⇐ v3        "Vector3Clamp"                   _R⟨v3⋄v3⋄v3⟩                                     # v min max                                       #
vector3ClampValue              ⇐ v3        "Vector3ClampValue"              _R⟨v3⋄f⋄f⟩                                       # v min max                                       #
vector3Equals                  ⇐ i         "Vector3Equals"                  _R⟨v3⋄v3⟩                                        # p q                                             #
vector3Refract                 ⇐ v3        "Vector3Refract"                 _R⟨v3⋄v3⋄f⟩                                      # v n r                                           #
vector4Zero                    ⇐ v4        "Vector4Zero"                    _R⟨⟩                                             #                                                 #
vector4One                     ⇐ v4        "Vector4One"                     _R⟨⟩                                             #                                                 #
vector4Add                     ⇐ v4        "Vector4Add"                     _R⟨v4⋄v4⟩                                        # v1 v2                                           #
vector4AddValue                ⇐ v4        "Vector4AddValue"                _R⟨v4⋄f⟩                                         # v add                                           #
vector4Subtract                ⇐ v4        "Vector4Subtract"                _R⟨v4⋄v4⟩                                        # v1 v2                                           #
vector4SubtractValue           ⇐ v4        "Vector4SubtractValue"           _R⟨v4⋄f⟩                                         # v add                                           #
vector4Length                  ⇐ f         "Vector4Length"                  _R⟨v4⟩                                           # v                                               #
vector4LengthSqr               ⇐ f         "Vector4LengthSqr"               _R⟨v4⟩                                           # v                                               #
vector4DotProduct              ⇐ f         "Vector4DotProduct"              _R⟨v4⋄v4⟩                                        # v1 v2                                           #
vector4Distance                ⇐ f         "Vector4Distance"                _R⟨v4⋄v4⟩                                        # v1 v2                                           #
vector4DistanceSqr             ⇐ f         "Vector4DistanceSqr"             _R⟨v4⋄v4⟩                                        # v1 v2                                           #
vector4Scale                   ⇐ v4        "Vector4Scale"                   _R⟨v4⋄f⟩                                         # v scale                                         #
vector4Multiply                ⇐ v4        "Vector4Multiply"                _R⟨v4⋄v4⟩                                        # v1 v2                                           #
vector4Negate                  ⇐ v4        "Vector4Negate"                  _R⟨v4⟩                                           # v                                               #
vector4Divide                  ⇐ v4        "Vector4Divide"                  _R⟨v4⋄v4⟩                                        # v1 v2                                           #
vector4Normalize               ⇐ v4        "Vector4Normalize"               _R⟨v4⟩                                           # v                                               #
vector4Min                     ⇐ v4        "Vector4Min"                     _R⟨v4⋄v4⟩                                        # v1 v2                                           #
vector4Max                     ⇐ v4        "Vector4Max"                     _R⟨v4⋄v4⟩                                        # v1 v2                                           #
vector4Lerp                    ⇐ v4        "Vector4Lerp"                    _R⟨v4⋄v4⋄f⟩                                      # v1 v2 amount                                    #
vector4MoveTowards             ⇐ v4        "Vector4MoveTowards"             _R⟨v4⋄v4⋄f⟩                                      # v target maxDistance                            #
vector4Invert                  ⇐ v4        "Vector4Invert"                  _R⟨v4⟩                                           # v                                               #
vector4Equals                  ⇐ i         "Vector4Equals"                  _R⟨v4⋄v4⟩                                        # p q                                             #
matrixDeterminant              ⇐ f         "MatrixDeterminant"              _R⟨matrix⟩                                       # mat                                             #
matrixTrace                    ⇐ f         "MatrixTrace"                    _R⟨matrix⟩                                       # mat                                             #
matrixTranspose                ⇐ matrix    "MatrixTranspose"                _R⟨matrix⟩                                       # mat                                             #
matrixInvert                   ⇐ matrix    "MatrixInvert"                   _R⟨matrix⟩                                       # mat                                             #
matrixIdentity                 ⇐ matrix    "MatrixIdentity"                 _R⟨⟩                                             #                                                 #
matrixAdd                      ⇐ matrix    "MatrixAdd"                      _R⟨matrix⋄matrix⟩                                # left right                                      #
matrixSubtract                 ⇐ matrix    "MatrixSubtract"                 _R⟨matrix⋄matrix⟩                                # left right                                      #
matrixMultiply                 ⇐ matrix    "MatrixMultiply"                 _R⟨matrix⋄matrix⟩                                # left right                                      #
matrixTranslate                ⇐ matrix    "MatrixTranslate"                _R⟨f⋄f⋄f⟩                                        # x y z                                           #
matrixRotate                   ⇐ matrix    "MatrixRotate"                   _R⟨v3⋄f⟩                                         # axis angle                                      #
matrixRotateX                  ⇐ matrix    "MatrixRotateX"                  _R⟨f⟩                                            # angle                                           #
matrixRotateY                  ⇐ matrix    "MatrixRotateY"                  _R⟨f⟩                                            # angle                                           #
matrixRotateZ                  ⇐ matrix    "MatrixRotateZ"                  _R⟨f⟩                                            # angle                                           #
matrixRotateXYZ                ⇐ matrix    "MatrixRotateXYZ"                _R⟨v3⟩                                           # angle                                           #
matrixRotateZYX                ⇐ matrix    "MatrixRotateZYX"                _R⟨v3⟩                                           # angle                                           #
matrixScale                    ⇐ matrix    "MatrixScale"                    _R⟨f⋄f⋄f⟩                                        # x y z                                           #
matrixFrustum                  ⇐ matrix    "MatrixFrustum"                  _R⟨"f64"⋄"f64"⋄"f64"⋄"f64"⋄"f64"⋄"f64"⟩          # left right bottom top near far                  #
matrixPerspective              ⇐ matrix    "MatrixPerspective"              _R⟨"f64"⋄"f64"⋄"f64"⋄"f64"⟩                      # fovY aspect nearPlane farPlane                  #
matrixOrtho                    ⇐ matrix    "MatrixOrtho"                    _R⟨"f64"⋄"f64"⋄"f64"⋄"f64"⋄"f64"⋄"f64"⟩          # left right bottom top nearPlane farPlane        #
matrixLookAt                   ⇐ matrix    "MatrixLookAt"                   _R⟨v3⋄v3⋄v3⟩                                     # eye target up                                   #
matrixToFloatV                 ⇐ float16   "MatrixToFloatV"                 _R⟨matrix⟩                                       # mat                                             #
quaternionAdd                  ⇐ quaternion"QuaternionAdd"                  _R⟨quaternion⋄quaternion⟩                        # q1 q2                                           #
quaternionAddValue             ⇐ quaternion"QuaternionAddValue"             _R⟨quaternion⋄f⟩                                 # q add                                           #
quaternionSubtract             ⇐ quaternion"QuaternionSubtract"             _R⟨quaternion⋄quaternion⟩                        # q1 q2                                           #
quaternionSubtractValue        ⇐ quaternion"QuaternionSubtractValue"        _R⟨quaternion⋄f⟩                                 # q sub                                           #
quaternionIdentity             ⇐ quaternion"QuaternionIdentity"             _R⟨⟩                                             #                                                 #
quaternionLength               ⇐ f         "QuaternionLength"               _R⟨quaternion⟩                                   # q                                               #
quaternionNormalize            ⇐ quaternion"QuaternionNormalize"            _R⟨quaternion⟩                                   # q                                               #
quaternionInvert               ⇐ quaternion"QuaternionInvert"               _R⟨quaternion⟩                                   # q                                               #
quaternionMultiply             ⇐ quaternion"QuaternionMultiply"             _R⟨quaternion⋄quaternion⟩                        # q1 q2                                           #
quaternionScale                ⇐ quaternion"QuaternionScale"                _R⟨quaternion⋄f⟩                                 # q mul                                           #
quaternionDivide               ⇐ quaternion"QuaternionDivide"               _R⟨quaternion⋄quaternion⟩                        # q1 q2                                           #
quaternionLerp                 ⇐ quaternion"QuaternionLerp"                 _R⟨quaternion⋄quaternion⋄f⟩                      # q1 q2 amount                                    #
quaternionNlerp                ⇐ quaternion"QuaternionNlerp"                _R⟨quaternion⋄quaternion⋄f⟩                      # q1 q2 amount                                    #
quaternionSlerp                ⇐ quaternion"QuaternionSlerp"                _R⟨quaternion⋄quaternion⋄f⟩                      # q1 q2 amount                                    #
quaternionCubicHermiteSpline   ⇐ quaternion"QuaternionCubicHermiteSpline"   _R⟨quaternion⋄quaternion⋄quaternion⋄quaternion⋄f⟩# q1 outTangent1 q2 inTangent2 t                  #
quaternionFromVector3ToVector3 ⇐ quaternion"QuaternionFromVector3ToVector3" _R⟨v3⋄v3⟩                                        # from to                                         #
quaternionFromMatrix           ⇐ quaternion"QuaternionFromMatrix"           _R⟨matrix⟩                                       # mat                                             #
quaternionToMatrix             ⇐ matrix    "QuaternionToMatrix"             _R⟨quaternion⟩                                   # q                                               #
quaternionFromAxisAngle        ⇐ quaternion"QuaternionFromAxisAngle"        _R⟨v3⋄f⟩                                         # axis angle                                      #
quaternionToAxisAngle          ⇐           "QuaternionToAxisAngle"          _R⟨quaternion⋄"*"∾v3⋄"*"∾f⟩                      # q outAxis outAngle                              #
quaternionToAxisAngleRef       ⇐           "QuaternionToAxisAngle"          _R⟨quaternion⋄"&"∾v3⋄"&"∾f⟩                      # q outAxis outAngle                              #
quaternionFromEuler            ⇐ quaternion"QuaternionFromEuler"            _R⟨f⋄f⋄f⟩                                        # pitch yaw roll                                  #
quaternionToEuler              ⇐ v3        "QuaternionToEuler"              _R⟨quaternion⟩                                   # q                                               #
quaternionTransform            ⇐ quaternion"QuaternionTransform"            _R⟨quaternion⋄matrix⟩                            # q mat                                           #
quaternionEquals               ⇐ i         "QuaternionEquals"               _R⟨quaternion⋄quaternion⟩                        # p q                                             #
