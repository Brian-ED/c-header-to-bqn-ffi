
⟨raylibPath⟩ ← •Import "src/loadConfig.bqn"
r ⇐ MakeImporter raylibPath

rAYLIB_VERSION_MAJOR ⇐ 5     #
rAYLIB_VERSION_MINOR ⇐ 0     #
rAYLIB_VERSION_PATCH ⇐ 0     #
rAYLIB_VERSION       ⇐ "5.0" #

configFlags ⇐ { # System/Window config flags
  vSYNC_HINT               ⇐ 64     # Set to try enabling V-Sync on GPU
  fULLSCREEN_MODE          ⇐ 2      # Set to run program in fullscreen
  wINDOW_RESIZABLE         ⇐ 4      # Set to allow resizable window
  wINDOW_UNDECORATED       ⇐ 8      # Set to disable window decoration (frame and buttons)
  wINDOW_HIDDEN            ⇐ 128    # Set to hide window
  wINDOW_MINIMIZED         ⇐ 512    # Set to minimize window (iconify)
  wINDOW_MAXIMIZED         ⇐ 1024   # Set to maximize window (expanded to monitor)
  wINDOW_UNFOCUSED         ⇐ 2048   # Set to window non focused
  wINDOW_TOPMOST           ⇐ 4096   # Set to window always on top
  wINDOW_ALWAYS_RUN        ⇐ 256    # Set to allow windows running while minimized
  wINDOW_TRANSPARENT       ⇐ 16     # Set to allow transparent framebuffer
  wINDOW_HIGHDPI           ⇐ 8192   # Set to support HighDPI
  wINDOW_MOUSE_PASSTHROUGH ⇐ 16384  # Set to support mouse passthrough, only supported when FLAG_WINDOW_UNDECORATED
  bORDERLESS_WINDOWED_MODE ⇐ 32768  # Set to run program in borderless windowed mode
  mSAA_4X_HINT             ⇐ 32     # Set to try enabling MSAA 4X
  iNTERLACED_HINT          ⇐ 65536  # Set to try enabling interlaced video format (for V3D)
}
traceLogLevel ⇐ { # Trace log level
  aLL     ⇐ 0  # Display all logs
  tRACE   ⇐ 1  # Trace logging, intended for internal use only
  dEBUG   ⇐ 2  # Debug logging, used for internal debugging, it should be disabled on release builds
  iNFO    ⇐ 3  # Info logging, used for program execution info
  wARNING ⇐ 4  # Warning logging, used on recoverable failures
  eRROR   ⇐ 5  # Error logging, used on unrecoverable failures
  fATAL   ⇐ 6  # Fatal logging, used to abort program: exit(EXIT_FAILURE)
  nONE    ⇐ 7  # Disable logging
}
keyboardKey ⇐ { # Keyboard keys (US keyboard layout)
  nULL          ⇐ 0    # Key: NULL, used for no key pressed
  aPOSTROPHE    ⇐ 39   # Key: '
  cOMMA         ⇐ 44   # Key: ,
  mINUS         ⇐ 45   # Key: -
  pERIOD        ⇐ 46   # Key: .
  sLASH         ⇐ 47   # Key: /
  zERO          ⇐ 48   # Key: 0
  oNE           ⇐ 49   # Key: 1
  tWO           ⇐ 50   # Key: 2
  tHREE         ⇐ 51   # Key: 3
  fOUR          ⇐ 52   # Key: 4
  fIVE          ⇐ 53   # Key: 5
  sIX           ⇐ 54   # Key: 6
  sEVEN         ⇐ 55   # Key: 7
  eIGHT         ⇐ 56   # Key: 8
  nINE          ⇐ 57   # Key: 9
  sEMICOLON     ⇐ 59   # Key: ;
  eQUAL         ⇐ 61   # Key: =
  a             ⇐ 65   # Key: A | a
  b             ⇐ 66   # Key: B | b
  c             ⇐ 67   # Key: C | c
  d             ⇐ 68   # Key: D | d
  e             ⇐ 69   # Key: E | e
  f             ⇐ 70   # Key: F | f
  g             ⇐ 71   # Key: G | g
  h             ⇐ 72   # Key: H | h
  i             ⇐ 73   # Key: I | i
  j             ⇐ 74   # Key: J | j
  k             ⇐ 75   # Key: K | k
  l             ⇐ 76   # Key: L | l
  m             ⇐ 77   # Key: M | m
  n             ⇐ 78   # Key: N | n
  o             ⇐ 79   # Key: O | o
  p             ⇐ 80   # Key: P | p
  q             ⇐ 81   # Key: Q | q
  r             ⇐ 82   # Key: R | r
  s             ⇐ 83   # Key: S | s
  t             ⇐ 84   # Key: T | t
  u             ⇐ 85   # Key: U | u
  v             ⇐ 86   # Key: V | v
  w             ⇐ 87   # Key: W | w
  x             ⇐ 88   # Key: X | x
  y             ⇐ 89   # Key: Y | y
  z             ⇐ 90   # Key: Z | z
  lEFT_BRACKET  ⇐ 91   # Key: [
  bACKSLASH     ⇐ 92   # Key: '\'
  rIGHT_BRACKET ⇐ 93   # Key: ]
  gRAVE         ⇐ 96   # Key: `
  sPACE         ⇐ 32   # Key: Space
  eSCAPE        ⇐ 256  # Key: Esc
  eNTER         ⇐ 257  # Key: Enter
  tAB           ⇐ 258  # Key: Tab
  bACKSPACE     ⇐ 259  # Key: Backspace
  iNSERT        ⇐ 260  # Key: Ins
  dELETE        ⇐ 261  # Key: Del
  rIGHT         ⇐ 262  # Key: Cursor right
  lEFT          ⇐ 263  # Key: Cursor left
  dOWN          ⇐ 264  # Key: Cursor down
  uP            ⇐ 265  # Key: Cursor up
  pAGE_UP       ⇐ 266  # Key: Page up
  pAGE_DOWN     ⇐ 267  # Key: Page down
  hOME          ⇐ 268  # Key: Home
  eND           ⇐ 269  # Key: End
  cAPS_LOCK     ⇐ 280  # Key: Caps lock
  sCROLL_LOCK   ⇐ 281  # Key: Scroll down
  nUM_LOCK      ⇐ 282  # Key: Num lock
  pRINT_SCREEN  ⇐ 283  # Key: Print screen
  pAUSE         ⇐ 284  # Key: Pause
  f1            ⇐ 290  # Key: F1
  f2            ⇐ 291  # Key: F2
  f3            ⇐ 292  # Key: F3
  f4            ⇐ 293  # Key: F4
  f5            ⇐ 294  # Key: F5
  f6            ⇐ 295  # Key: F6
  f7            ⇐ 296  # Key: F7
  f8            ⇐ 297  # Key: F8
  f9            ⇐ 298  # Key: F9
  f10           ⇐ 299  # Key: F10
  f11           ⇐ 300  # Key: F11
  f12           ⇐ 301  # Key: F12
  lEFT_SHIFT    ⇐ 340  # Key: Shift left
  lEFT_CONTROL  ⇐ 341  # Key: Control left
  lEFT_ALT      ⇐ 342  # Key: Alt left
  lEFT_SUPER    ⇐ 343  # Key: Super left
  rIGHT_SHIFT   ⇐ 344  # Key: Shift right
  rIGHT_CONTROL ⇐ 345  # Key: Control right
  rIGHT_ALT     ⇐ 346  # Key: Alt right
  rIGHT_SUPER   ⇐ 347  # Key: Super right
  kB_MENU       ⇐ 348  # Key: KB menu
  kP_0          ⇐ 320  # Key: Keypad 0
  kP_1          ⇐ 321  # Key: Keypad 1
  kP_2          ⇐ 322  # Key: Keypad 2
  kP_3          ⇐ 323  # Key: Keypad 3
  kP_4          ⇐ 324  # Key: Keypad 4
  kP_5          ⇐ 325  # Key: Keypad 5
  kP_6          ⇐ 326  # Key: Keypad 6
  kP_7          ⇐ 327  # Key: Keypad 7
  kP_8          ⇐ 328  # Key: Keypad 8
  kP_9          ⇐ 329  # Key: Keypad 9
  kP_DECIMAL    ⇐ 330  # Key: Keypad .
  kP_DIVIDE     ⇐ 331  # Key: Keypad /
  kP_MULTIPLY   ⇐ 332  # Key: Keypad *
  kP_SUBTRACT   ⇐ 333  # Key: Keypad -
  kP_ADD        ⇐ 334  # Key: Keypad +
  kP_ENTER      ⇐ 335  # Key: Keypad Enter
  kP_EQUAL      ⇐ 336  # Key: Keypad =
  bACK          ⇐ 4    # Key: Android back button
  mENU          ⇐ 82   # Key: Android menu button
  vOLUME_UP     ⇐ 24   # Key: Android volume up button
  vOLUME_DOWN   ⇐ 25   # Key: Android volume down button
}
mouseButton ⇐ { # Mouse buttons
  lEFT    ⇐ 0  # Mouse button left
  rIGHT   ⇐ 1  # Mouse button right
  mIDDLE  ⇐ 2  # Mouse button middle (pressed wheel)
  sIDE    ⇐ 3  # Mouse button side (advanced mouse device)
  eXTRA   ⇐ 4  # Mouse button extra (advanced mouse device)
  fORWARD ⇐ 5  # Mouse button forward (advanced mouse device)
  bACK    ⇐ 6  # Mouse button back (advanced mouse device)
}
mouseCursor ⇐ { # Mouse cursor
  dEFAULT       ⇐ 0   # Default pointer shape
  aRROW         ⇐ 1   # Arrow shape
  iBEAM         ⇐ 2   # Text writing cursor shape
  cROSSHAIR     ⇐ 3   # Cross shape
  pOINTING_HAND ⇐ 4   # Pointing hand cursor
  rESIZE_EW     ⇐ 5   # Horizontal resize/move arrow shape
  rESIZE_NS     ⇐ 6   # Vertical resize/move arrow shape
  rESIZE_NWSE   ⇐ 7   # Top-left to bottom-right diagonal resize/move arrow shape
  rESIZE_NESW   ⇐ 8   # The top-right to bottom-left diagonal resize/move arrow shape
  rESIZE_ALL    ⇐ 9   # The omnidirectional resize/move cursor shape
  nOT_ALLOWED   ⇐ 10  # The operation-not-allowed shape
}
gamepadButton ⇐ { # Gamepad buttons
  uNKNOWN          ⇐ 0   # Unknown button, just for error checking
  lEFT_FACE_UP     ⇐ 1   # Gamepad left DPAD up button
  lEFT_FACE_RIGHT  ⇐ 2   # Gamepad left DPAD right button
  lEFT_FACE_DOWN   ⇐ 3   # Gamepad left DPAD down button
  lEFT_FACE_LEFT   ⇐ 4   # Gamepad left DPAD left button
  rIGHT_FACE_UP    ⇐ 5   # Gamepad right button up (i.e. PS3: Triangle, Xbox: Y)
  rIGHT_FACE_RIGHT ⇐ 6   # Gamepad right button right (i.e. PS3: Square, Xbox: X)
  rIGHT_FACE_DOWN  ⇐ 7   # Gamepad right button down (i.e. PS3: Cross, Xbox: A)
  rIGHT_FACE_LEFT  ⇐ 8   # Gamepad right button left (i.e. PS3: Circle, Xbox: B)
  lEFT_TRIGGER_1   ⇐ 9   # Gamepad top/back trigger left (first), it could be a trailing button
  lEFT_TRIGGER_2   ⇐ 10  # Gamepad top/back trigger left (second), it could be a trailing button
  rIGHT_TRIGGER_1  ⇐ 11  # Gamepad top/back trigger right (one), it could be a trailing button
  rIGHT_TRIGGER_2  ⇐ 12  # Gamepad top/back trigger right (second), it could be a trailing button
  mIDDLE_LEFT      ⇐ 13  # Gamepad center buttons, left one (i.e. PS3: Select)
  mIDDLE           ⇐ 14  # Gamepad center buttons, middle one (i.e. PS3: PS, Xbox: XBOX)
  mIDDLE_RIGHT     ⇐ 15  # Gamepad center buttons, right one (i.e. PS3: Start)
  lEFT_THUMB       ⇐ 16  # Gamepad joystick pressed button left
  rIGHT_THUMB      ⇐ 17  # Gamepad joystick pressed button right
}
gamepadAxis ⇐ { # Gamepad axis
  lEFT_X        ⇐ 0  # Gamepad left stick X axis
  lEFT_Y        ⇐ 1  # Gamepad left stick Y axis
  rIGHT_X       ⇐ 2  # Gamepad right stick X axis
  rIGHT_Y       ⇐ 3  # Gamepad right stick Y axis
  lEFT_TRIGGER  ⇐ 4  # Gamepad back trigger left, pressure level: [1..-1]
  rIGHT_TRIGGER ⇐ 5  # Gamepad back trigger right, pressure level: [1..-1]
}
materialMapIndex ⇐ { # Material map index
  aLBEDO     ⇐ 0   # Albedo material (same as: MATERIAL_MAP_DIFFUSE)
  mETALNESS  ⇐ 1   # Metalness material (same as: MATERIAL_MAP_SPECULAR)
  nORMAL     ⇐ 2   # Normal material
  rOUGHNESS  ⇐ 3   # Roughness material
  oCCLUSION  ⇐ 4   # Ambient occlusion material
  eMISSION   ⇐ 5   # Emission material
  hEIGHT     ⇐ 6   # Heightmap material
  cUBEMAP    ⇐ 7   # Cubemap material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
  iRRADIANCE ⇐ 8   # Irradiance material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
  pREFILTER  ⇐ 9   # Prefilter material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
  bRDF       ⇐ 10  # Brdf material
}
shaderLocationIndex ⇐ { # Shader location index
  vERTEX_POSITION   ⇐ 0   # Shader location: vertex attribute: position
  vERTEX_TEXCOORD01 ⇐ 1   # Shader location: vertex attribute: texcoord01
  vERTEX_TEXCOORD02 ⇐ 2   # Shader location: vertex attribute: texcoord02
  vERTEX_NORMAL     ⇐ 3   # Shader location: vertex attribute: normal
  vERTEX_TANGENT    ⇐ 4   # Shader location: vertex attribute: tangent
  vERTEX_COLOR      ⇐ 5   # Shader location: vertex attribute: color
  mATRIX_MVP        ⇐ 6   # Shader location: matrix uniform: model-view-projection
  mATRIX_VIEW       ⇐ 7   # Shader location: matrix uniform: view (camera transform)
  mATRIX_PROJECTION ⇐ 8   # Shader location: matrix uniform: projection
  mATRIX_MODEL      ⇐ 9   # Shader location: matrix uniform: model (transform)
  mATRIX_NORMAL     ⇐ 10  # Shader location: matrix uniform: normal
  vECTOR_VIEW       ⇐ 11  # Shader location: vector uniform: view
  cOLOR_DIFFUSE     ⇐ 12  # Shader location: vector uniform: diffuse color
  cOLOR_SPECULAR    ⇐ 13  # Shader location: vector uniform: specular color
  cOLOR_AMBIENT     ⇐ 14  # Shader location: vector uniform: ambient color
  mAP_ALBEDO        ⇐ 15  # Shader location: sampler2d texture: albedo (same as: SHADER_LOC_MAP_DIFFUSE)
  mAP_METALNESS     ⇐ 16  # Shader location: sampler2d texture: metalness (same as: SHADER_LOC_MAP_SPECULAR)
  mAP_NORMAL        ⇐ 17  # Shader location: sampler2d texture: normal
  mAP_ROUGHNESS     ⇐ 18  # Shader location: sampler2d texture: roughness
  mAP_OCCLUSION     ⇐ 19  # Shader location: sampler2d texture: occlusion
  mAP_EMISSION      ⇐ 20  # Shader location: sampler2d texture: emission
  mAP_HEIGHT        ⇐ 21  # Shader location: sampler2d texture: height
  mAP_CUBEMAP       ⇐ 22  # Shader location: samplerCube texture: cubemap
  mAP_IRRADIANCE    ⇐ 23  # Shader location: samplerCube texture: irradiance
  mAP_PREFILTER     ⇐ 24  # Shader location: samplerCube texture: prefilter
  mAP_BRDF          ⇐ 25  # Shader location: sampler2d texture: brdf
}
shaderUniformDataType ⇐ { # Shader uniform data type
  fLOAT     ⇐ 0  # Shader uniform type: float
  vEC2      ⇐ 1  # Shader uniform type: vec2 (2 float)
  vEC3      ⇐ 2  # Shader uniform type: vec3 (3 float)
  vEC4      ⇐ 3  # Shader uniform type: vec4 (4 float)
  iNT       ⇐ 4  # Shader uniform type: int
  iVEC2     ⇐ 5  # Shader uniform type: ivec2 (2 int)
  iVEC3     ⇐ 6  # Shader uniform type: ivec3 (3 int)
  iVEC4     ⇐ 7  # Shader uniform type: ivec4 (4 int)
  sAMPLER2D ⇐ 8  # Shader uniform type: sampler2d
}
shaderAttributeDataType ⇐ { # Shader attribute data types
  fLOAT ⇐ 0  # Shader attribute type: float
  vEC2  ⇐ 1  # Shader attribute type: vec2 (2 float)
  vEC3  ⇐ 2  # Shader attribute type: vec3 (3 float)
  vEC4  ⇐ 3  # Shader attribute type: vec4 (4 float)
}
pixelFormat ⇐ { # Pixel formats
  uNCOMPRESSED_GRAYSCALE    ⇐ 1   # 8 bit per pixel (no alpha)
  uNCOMPRESSED_GRAY_ALPHA   ⇐ 2   # 8*2 bpp (2 channels)
  uNCOMPRESSED_R5G6B5       ⇐ 3   # 16 bpp
  uNCOMPRESSED_R8G8B8       ⇐ 4   # 24 bpp
  uNCOMPRESSED_R5G5B5A1     ⇐ 5   # 16 bpp (1 bit alpha)
  uNCOMPRESSED_R4G4B4A4     ⇐ 6   # 16 bpp (4 bit alpha)
  uNCOMPRESSED_R8G8B8A8     ⇐ 7   # 32 bpp
  uNCOMPRESSED_R32          ⇐ 8   # 32 bpp (1 channel - float)
  uNCOMPRESSED_R32G32B32    ⇐ 9   # 32*3 bpp (3 channels - float)
  uNCOMPRESSED_R32G32B32A32 ⇐ 10  # 32*4 bpp (4 channels - float)
  uNCOMPRESSED_R16          ⇐ 11  # 16 bpp (1 channel - half float)
  uNCOMPRESSED_R16G16B16    ⇐ 12  # 16*3 bpp (3 channels - half float)
  uNCOMPRESSED_R16G16B16A16 ⇐ 13  # 16*4 bpp (4 channels - half float)
  cOMPRESSED_DXT1_RGB       ⇐ 14  # 4 bpp (no alpha)
  cOMPRESSED_DXT1_RGBA      ⇐ 15  # 4 bpp (1 bit alpha)
  cOMPRESSED_DXT3_RGBA      ⇐ 16  # 8 bpp
  cOMPRESSED_DXT5_RGBA      ⇐ 17  # 8 bpp
  cOMPRESSED_ETC1_RGB       ⇐ 18  # 4 bpp
  cOMPRESSED_ETC2_RGB       ⇐ 19  # 4 bpp
  cOMPRESSED_ETC2_EAC_RGBA  ⇐ 20  # 8 bpp
  cOMPRESSED_PVRT_RGB       ⇐ 21  # 4 bpp
  cOMPRESSED_PVRT_RGBA      ⇐ 22  # 4 bpp
  cOMPRESSED_ASTC_4x4_RGBA  ⇐ 23  # 8 bpp
  cOMPRESSED_ASTC_8x8_RGBA  ⇐ 24  # 2 bpp
}
textureFilter ⇐ { # Texture parameters: filter mode
  pOINT           ⇐ 0  # No filter, just pixel approximation
  bILINEAR        ⇐ 1  # Linear filtering
  tRILINEAR       ⇐ 2  # Trilinear filtering (linear with mipmaps)
  aNISOTROPIC_4X  ⇐ 3  # Anisotropic filtering 4x
  aNISOTROPIC_8X  ⇐ 4  # Anisotropic filtering 8x
  aNISOTROPIC_16X ⇐ 5  # Anisotropic filtering 16x
}
textureWrap ⇐ { # Texture parameters: wrap mode
  rEPEAT        ⇐ 0  # Repeats texture in tiled mode
  cLAMP         ⇐ 1  # Clamps texture to edge pixel in tiled mode
  mIRROR_REPEAT ⇐ 2  # Mirrors and repeats the texture in tiled mode
  mIRROR_CLAMP  ⇐ 3  # Mirrors and clamps to border the texture in tiled mode
}
cubemapLayout ⇐ { # Cubemap layouts
  aUTO_DETECT         ⇐ 0  # Automatically detect layout type
  lINE_VERTICAL       ⇐ 1  # Layout is defined by a vertical line with faces
  lINE_HORIZONTAL     ⇐ 2  # Layout is defined by a horizontal line with faces
  cROSS_THREE_BY_FOUR ⇐ 3  # Layout is defined by a 3x4 cross with cubemap faces
  cROSS_FOUR_BY_THREE ⇐ 4  # Layout is defined by a 4x3 cross with cubemap faces
  pANORAMA            ⇐ 5  # Layout is defined by a panorama image (equirrectangular map)
}
fontType ⇐ { # Font type, defines generation method
  dEFAULT ⇐ 0  # Default font generation, anti-aliased
  bITMAP  ⇐ 1  # Bitmap font generation, no anti-aliasing
  sDF     ⇐ 2  # SDF font generation, requires external shader
}
blendMode ⇐ { # Color blending modes (pre-defined)
  aLPHA             ⇐ 0  # Blend textures considering alpha (default)
  aDDITIVE          ⇐ 1  # Blend textures adding colors
  mULTIPLIED        ⇐ 2  # Blend textures multiplying colors
  aDD_COLORS        ⇐ 3  # Blend textures adding colors (alternative)
  sUBTRACT_COLORS   ⇐ 4  # Blend textures subtracting colors (alternative)
  aLPHA_PREMULTIPLY ⇐ 5  # Blend premultiplied textures considering alpha
  cUSTOM            ⇐ 6  # Blend textures using custom src/dst factors (use rlSetBlendFactors())
  cUSTOM_SEPARATE   ⇐ 7  # Blend textures using custom rgb/alpha separate src/dst factors (use rlSetBlendFactorsSeparate())
}
gesture ⇐ { # Gesture
  nONE        ⇐ 0    # No gesture
  tAP         ⇐ 1    # Tap gesture
  dOUBLETAP   ⇐ 2    # Double tap gesture
  hOLD        ⇐ 4    # Hold gesture
  dRAG        ⇐ 8    # Drag gesture
  sWIPE_RIGHT ⇐ 16   # Swipe right gesture
  sWIPE_LEFT  ⇐ 32   # Swipe left gesture
  sWIPE_UP    ⇐ 64   # Swipe up gesture
  sWIPE_DOWN  ⇐ 128  # Swipe down gesture
  pINCH_IN    ⇐ 256  # Pinch in gesture
  pINCH_OUT   ⇐ 512  # Pinch out gesture
}
cameraMode ⇐ { # Camera system modes
  cUSTOM       ⇐ 0  # Custom camera
  fREE         ⇐ 1  # Free camera
  oRBITAL      ⇐ 2  # Orbital camera
  fIRST_PERSON ⇐ 3  # First person camera
  tHIRD_PERSON ⇐ 4  # Third person camera
}
cameraProjection ⇐ { # Camera projection
  pERSPECTIVE  ⇐ 0  # Perspective projection
  oRTHOGRAPHIC ⇐ 1  # Orthographic projection
}
nPatchLayout ⇐ { # N-patch layout
  nINE_PATCH             ⇐ 0  # Npatch layout: 3x3 tiles
  tHREE_PATCH_VERTICAL   ⇐ 1  # Npatch layout: 1x3 tiles
  tHREE_PATCH_HORIZONTAL ⇐ 2  # Npatch layout: 3x1 tiles
}

v2 ⇐ ⟨ # Vector2, 2 components
  f # x  # Vector x component
  f # y  # Vector y component
⟩
v3 ⇐ ⟨ # Vector3, 3 components
  f # x  # Vector x component
  f # y  # Vector y component
  f # z  # Vector z component
⟩
v4 ⇐ ⟨ # Vector4, 4 components
  f # x  # Vector x component
  f # y  # Vector y component
  f # z  # Vector z component
  f # w  # Vector w component
⟩
quaternion ⇐ v4 # Quaternion, 4 components (Vector4 alias)
matrix ⇐ ⟨ # Matrix, 4x4 components, column major, OpenGL style, right-handed
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
color ⇐ ⟨ # Color, 4 components, R8G8B8A8 (32bit)
  u8 # r  # Color red value
  u8 # g  # Color green value
  u8 # b  # Color blue value
  u8 # a  # Color alpha value
⟩
rectangle ⇐ ⟨ # Rectangle, 4 components
  f # x       # Rectangle top-left corner position x
  f # y       # Rectangle top-left corner position y
  f # width   # Rectangle width
  f # height  # Rectangle height
⟩
image ⇐ ⟨ # Image, pixel data stored in CPU memory (RAM)
  ptr # data     # Image raw data
  i   # width    # Image base width
  i   # height   # Image base height
  i   # mipmaps  # Mipmap levels, 1 by default
  i   # format   # Data format (PixelFormat type)
⟩
texture ⇐ ⟨ # Texture, tex data stored in GPU memory (VRAM)
  u # id       # OpenGL texture id
  i # width    # Texture base width
  i # height   # Texture base height
  i # mipmaps  # Mipmap levels, 1 by default
  i # format   # Data format (PixelFormat type)
⟩
texture2D ⇐ texture # Texture2D, same as Texture
textureCubemap ⇐ texture # TextureCubemap, same as Texture
renderTexture ⇐ ⟨ # RenderTexture, fbo for texture rendering
  u       # id       # OpenGL framebuffer object id
  texture # texture  # Color buffer attachment texture
  texture # depth    # Depth buffer attachment texture
⟩
renderTexture2D ⇐ renderTexture # RenderTexture2D, same as RenderTexture
nPatchInfo ⇐ ⟨ # NPatchInfo, n-patch layout info
  rectangle # source  # Texture source rectangle
  i         # left    # Left border offset
  i         # top     # Top border offset
  i         # right   # Right border offset
  i         # bottom  # Bottom border offset
  i         # layout  # Layout of the n-patch: 3x3, 1x3 or 3x1
⟩
glyphInfo ⇐ ⟨ # GlyphInfo, font characters glyphs info
  i     # value     # Character value (Unicode)
  i     # offsetX   # Character offset X when drawing
  i     # offsetY   # Character offset Y when drawing
  i     # advanceX  # Character advance position X
  image # image     # Character image data
⟩
font ⇐ ⟨ # Font, font texture and GlyphInfo array data
  i             # baseSize      # Base size (default chars height)
  i             # glyphCount    # Number of glyph characters
  i             # glyphPadding  # Padding around the glyph characters
  texture2D     # texture       # Texture atlas containing the glyphs
  "*"∾rectangle # recs          # Rectangles in texture for the glyphs
  "*"∾glyphInfo # glyphs        # Glyphs info data
⟩
camera3D ⇐ ⟨ # Camera, defines position/orientation in 3d space
  v3 # position    # Camera position
  v3 # target      # Camera target it looks-at
  v3 # up          # Camera up vector (rotation over its axis)
  f  # fovy        # Camera field-of-view aperture in Y (degrees) in perspective, used as near plane width in orthographic
  i  # projection  # Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
⟩
camera ⇐ camera3D # Camera type fallback, defaults to Camera3D
camera2D ⇐ ⟨ # Camera2D, defines position/orientation in 2d space
  v2 # offset    # Camera offset (displacement from target)
  v2 # target    # Camera target (rotation and zoom origin)
  f  # rotation  # Camera rotation in degrees
  f  # zoom      # Camera zoom (scaling), should be 1.0f by default
⟩
mesh ⇐ ⟨ # Mesh, vertex data and vao/vbo
  i      # vertexCount    # Number of vertices stored in arrays
  i      # triangleCount  # Number of triangles stored (indexed or not)
  "*"∾f  # vertices       # Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
  "*"∾f  # texcoords      # Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
  "*"∾f  # texcoords2     # Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)
  "*"∾f  # normals        # Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
  "*"∾f  # tangents       # Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
  ustr   # colors         # Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
  "*u16" # indices        # Vertex indices (in case vertex data comes indexed)
  "*"∾f  # animVertices   # Animated vertex positions (after bones transformations)
  "*"∾f  # animNormals    # Animated normals (after bones transformations)
  ustr   # boneIds        # Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning)
  "*"∾f  # boneWeights    # Vertex bone weight, up to 4 bones influence by vertex (skinning)
  u      # vaoId          # OpenGL Vertex Array Object id
  "*"∾u  # vboId          # OpenGL Vertex Buffer Objects id (default vertex data)
⟩
shader ⇐ ⟨ # Shader
  u     # id    # Shader program id
  "*"∾i # locs  # Shader locations array (RL_MAX_SHADER_LOCATIONS)
⟩
materialMap ⇐ ⟨ # MaterialMap
  texture2D # texture  # Material map texture
  color     # color    # Material map color
  f         # value    # Material map value
⟩
material ⇐ ⟨ # Material, includes shader and maps
  shader          # shader  # Material shader
  "*"∾materialMap # maps    # Material maps array (MAX_MATERIAL_MAPS)
  "[4]"∾f         # params  # Material generic parameters (if required)
⟩
transform ⇐ ⟨ # Transform, vertex transformation data
  v3         # translation  # Translation
  quaternion # rotation     # Rotation
  v3         # scale        # Scale
⟩
boneInfo ⇐ ⟨ # Bone, skeletal animation bone
  "[32]"∾u8 # name    # Bone name
  i         # parent  # Bone parent
⟩
model ⇐ ⟨ # Model, meshes, materials and animation data
  matrix        # transform      # Local transform matrix
  i             # meshCount      # Number of meshes
  i             # materialCount  # Number of materials
  "*"∾mesh      # meshes         # Meshes array
  "*"∾material  # materials      # Materials array
  "*"∾i         # meshMaterial   # Mesh material number
  i             # boneCount      # Number of bones
  "*"∾boneInfo  # bones          # Bones information (skeleton)
  "*"∾transform # bindPose       # Bones base transformation (pose)
⟩
modelAnimation ⇐ ⟨ # ModelAnimation
  i              # boneCount   # Number of bones
  i              # frameCount  # Number of animation frames
  "*"∾boneInfo   # bones       # Bones information (skeleton)
  "**"∾transform # framePoses  # Poses array by frame
  "[32]"∾u8      # name        # Animation name
⟩
ray ⇐ ⟨ # Ray, ray for raycasting
  v3 # position   # Ray position (origin)
  v3 # direction  # Ray direction
⟩
rayCollision ⇐ ⟨ # RayCollision, ray hit information
  bool # hit       # Did the ray hit something?
  f    # distance  # Distance to the nearest hit
  v3   # point     # Point of the nearest hit
  v3   # normal    # Surface normal of hit
⟩
boundingBox ⇐ ⟨ # BoundingBox
  v3 # min  # Minimum vertex box-corner
  v3 # max  # Maximum vertex box-corner
⟩
wave ⇐ ⟨ # Wave, audio wave data
  u   # frameCount  # Total number of frames (considering channels)
  u   # sampleRate  # Frequency (samples per second)
  u   # sampleSize  # Bit depth (bits per sample): 8, 16, 32 (24 not supported)
  u   # channels    # Number of channels (1-mono, 2-stereo, ...)
  ptr # data        # Buffer data pointer
⟩
audioStream ⇐ ⟨ # AudioStream, custom audio stream
  ptr # buffer      # Pointer to internal data used by the audio system
  ptr # processor   # Pointer to internal data processor, useful for audio effects
  u   # sampleRate  # Frequency (samples per second)
  u   # sampleSize  # Bit depth (bits per sample): 8, 16, 32 (24 not supported)
  u   # channels    # Number of channels (1-mono, 2-stereo, ...)
⟩
sound ⇐ ⟨ # Sound
  audioStream # stream      # Audio stream
  u           # frameCount  # Total number of frames (considering channels)
⟩
music ⇐ ⟨ # Music, audio stream, anything longer than ~10 seconds should be streamed
  audioStream # stream      # Audio stream
  u           # frameCount  # Total number of frames (considering channels)
  bool        # looping     # Music looping enable
  i           # ctxType     # Type of music context (audio filetype)
  ptr         # ctxData     # Audio context data, depends on type
⟩
vrDeviceInfo ⇐ ⟨ # VrDeviceInfo, Head-Mounted-Display device parameters
  i       # hResolution             # Horizontal resolution in pixels
  i       # vResolution             # Vertical resolution in pixels
  f       # hScreenSize             # Horizontal size in meters
  f       # vScreenSize             # Vertical size in meters
  f       # vScreenCenter           # Screen center in meters
  f       # eyeToScreenDistance     # Distance between eye and display in meters
  f       # lensSeparationDistance  # Lens separation distance in meters
  f       # interpupillaryDistance  # IPD (distance between pupils) in meters
  "[4]"∾f # lensDistortionValues    # Lens distortion constant parameters
  "[4]"∾f # chromaAbCorrection      # Chromatic aberration correction parameters
⟩
vrStereoConfig ⇐ ⟨ # VrStereoConfig, VR stereo rendering configuration for simulator
  "[2]"∾matrix # projection         # VR projection matrices (per eye)
  "[2]"∾matrix # viewOffset         # VR view offset matrices (per eye)
  "[2]"∾f      # leftLensCenter     # VR left lens center
  "[2]"∾f      # rightLensCenter    # VR right lens center
  "[2]"∾f      # leftScreenCenter   # VR left screen center
  "[2]"∾f      # rightScreenCenter  # VR right screen center
  "[2]"∾f      # scale              # VR distortion scale
  "[2]"∾f      # scaleIn            # VR distortion scale in
⟩
filePathList ⇐ ⟨ # File path list
  u       # capacity  # Filepaths max entries
  u       # count     # Filepaths entries count
  "*"∾str # paths     # Filepaths entries
⟩
automationEvent ⇐ ⟨ # Automation event
  u       # frame   # Event frame
  u       # type    # Event type (AutomationEventType)
  "[4]"∾i # params  # Event parameters (if required)
⟩
automationEventList ⇐ ⟨ # Automation event list
  u                   # capacity  # Events max entries (MAX_AUTOMATION_EVENTS)
  u                   # count     # Events entries count
  "*"∾automationEvent # events    # Events entries
⟩

initWindow                       ⇐                         "InitWindow"                       _R⟨i⋄i⋄str⟩                                       # width height title                                                # Initialize window and OpenGL context
closeWindow                      ⇐                         "CloseWindow"                      _R⟨⟩                                              #                                                                   # Close window and unload OpenGL context
windowShouldClose                ⇐ bool                    "WindowShouldClose"                _R⟨⟩                                              #                                                                   # Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
isWindowReady                    ⇐ bool                    "IsWindowReady"                    _R⟨⟩                                              #                                                                   # Check if window has been initialized successfully
isWindowFullscreen               ⇐ bool                    "IsWindowFullscreen"               _R⟨⟩                                              #                                                                   # Check if window is currently fullscreen
isWindowHidden                   ⇐ bool                    "IsWindowHidden"                   _R⟨⟩                                              #                                                                   # Check if window is currently hidden (only PLATFORM_DESKTOP)
isWindowMinimized                ⇐ bool                    "IsWindowMinimized"                _R⟨⟩                                              #                                                                   # Check if window is currently minimized (only PLATFORM_DESKTOP)
isWindowMaximized                ⇐ bool                    "IsWindowMaximized"                _R⟨⟩                                              #                                                                   # Check if window is currently maximized (only PLATFORM_DESKTOP)
isWindowFocused                  ⇐ bool                    "IsWindowFocused"                  _R⟨⟩                                              #                                                                   # Check if window is currently focused (only PLATFORM_DESKTOP)
isWindowResized                  ⇐ bool                    "IsWindowResized"                  _R⟨⟩                                              #                                                                   # Check if window has been resized last frame
isWindowState                    ⇐ bool                    "IsWindowState"                    _R⟨u⟩                                             # flag                                                              # Check if one specific window flag is enabled
setWindowState                   ⇐                         "SetWindowState"                   _R⟨u⟩                                             # flags                                                             # Set window configuration state using flags (only PLATFORM_DESKTOP)
clearWindowState                 ⇐                         "ClearWindowState"                 _R⟨u⟩                                             # flags                                                             # Clear window configuration state flags
toggleFullscreen                 ⇐                         "ToggleFullscreen"                 _R⟨⟩                                              #                                                                   # Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
toggleBorderlessWindowed         ⇐                         "ToggleBorderlessWindowed"         _R⟨⟩                                              #                                                                   # Toggle window state: borderless windowed (only PLATFORM_DESKTOP)
maximizeWindow                   ⇐                         "MaximizeWindow"                   _R⟨⟩                                              #                                                                   # Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
minimizeWindow                   ⇐                         "MinimizeWindow"                   _R⟨⟩                                              #                                                                   # Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
restoreWindow                    ⇐                         "RestoreWindow"                    _R⟨⟩                                              #                                                                   # Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
setWindowIcon                    ⇐                         "SetWindowIcon"                    _R⟨image⟩                                         # image                                                             # Set icon for window (single image, RGBA 32bit, only PLATFORM_DESKTOP)
setWindowIcons                   ⇐                         "SetWindowIcons"                   _R⟨"*"∾image⋄i⟩                                   # images count                                                      # Set icon for window (multiple images, RGBA 32bit, only PLATFORM_DESKTOP)
setWindowIconsRef                ⇐                         "SetWindowIcons"                   _R⟨"&"∾image⋄i⟩                                   # images count                                                      # Set icon for window (multiple images, RGBA 32bit, only PLATFORM_DESKTOP)
setWindowTitle                   ⇐                         "SetWindowTitle"                   _R⟨str⟩                                           # title                                                             # Set title for window (only PLATFORM_DESKTOP and PLATFORM_WEB)
setWindowPosition                ⇐                         "SetWindowPosition"                _R⟨i⋄i⟩                                           # x y                                                               # Set window position on screen (only PLATFORM_DESKTOP)
setWindowMonitor                 ⇐                         "SetWindowMonitor"                 _R⟨i⟩                                             # monitor                                                           # Set monitor for the current window
setWindowMinSize                 ⇐                         "SetWindowMinSize"                 _R⟨i⋄i⟩                                           # width height                                                      # Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
setWindowMaxSize                 ⇐                         "SetWindowMaxSize"                 _R⟨i⋄i⟩                                           # width height                                                      # Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
setWindowSize                    ⇐                         "SetWindowSize"                    _R⟨i⋄i⟩                                           # width height                                                      # Set window dimensions
setWindowOpacity                 ⇐                         "SetWindowOpacity"                 _R⟨f⟩                                             # opacity                                                           # Set window opacity [0.0f..1.0f] (only PLATFORM_DESKTOP)
setWindowFocused                 ⇐                         "SetWindowFocused"                 _R⟨⟩                                              #                                                                   # Set window focused (only PLATFORM_DESKTOP)
getWindowHandle                  ⇐ ptr                     "GetWindowHandle"                  _R⟨⟩                                              #                                                                   # Get native window handle
getScreenWidth                   ⇐ i                       "GetScreenWidth"                   _R⟨⟩                                              #                                                                   # Get current screen width
getScreenHeight                  ⇐ i                       "GetScreenHeight"                  _R⟨⟩                                              #                                                                   # Get current screen height
getRenderWidth                   ⇐ i                       "GetRenderWidth"                   _R⟨⟩                                              #                                                                   # Get current render width (it considers HiDPI)
getRenderHeight                  ⇐ i                       "GetRenderHeight"                  _R⟨⟩                                              #                                                                   # Get current render height (it considers HiDPI)
getMonitorCount                  ⇐ i                       "GetMonitorCount"                  _R⟨⟩                                              #                                                                   # Get number of connected monitors
getCurrentMonitor                ⇐ i                       "GetCurrentMonitor"                _R⟨⟩                                              #                                                                   # Get current connected monitor
getMonitorPosition               ⇐ v2                      "GetMonitorPosition"               _R⟨i⟩                                             # monitor                                                           # Get specified monitor position
getMonitorWidth                  ⇐ i                       "GetMonitorWidth"                  _R⟨i⟩                                             # monitor                                                           # Get specified monitor width (current video mode used by monitor)
getMonitorHeight                 ⇐ i                       "GetMonitorHeight"                 _R⟨i⟩                                             # monitor                                                           # Get specified monitor height (current video mode used by monitor)
getMonitorPhysicalWidth          ⇐ i                       "GetMonitorPhysicalWidth"          _R⟨i⟩                                             # monitor                                                           # Get specified monitor physical width in millimetres
getMonitorPhysicalHeight         ⇐ i                       "GetMonitorPhysicalHeight"         _R⟨i⟩                                             # monitor                                                           # Get specified monitor physical height in millimetres
getMonitorRefreshRate            ⇐ i                       "GetMonitorRefreshRate"            _R⟨i⟩                                             # monitor                                                           # Get specified monitor refresh rate
getWindowPosition                ⇐ v2                      "GetWindowPosition"                _R⟨⟩                                              #                                                                   # Get window position XY on monitor
getWindowScaleDPI                ⇐ v2                      "GetWindowScaleDPI"                _R⟨⟩                                              #                                                                   # Get window scale DPI factor
getMonitorName                   ⇐ (ptr⊣str)               "GetMonitorName"                   _R⟨i⟩                                             # monitor                                                           # Get the human-readable, UTF-8 encoded name of the specified monitor
setClipboardText                 ⇐                         "SetClipboardText"                 _R⟨str⟩                                           # text                                                              # Set clipboard text content
getClipboardText                 ⇐ (ptr⊣str)               "GetClipboardText"                 _R⟨⟩                                              #                                                                   # Get clipboard text content
enableEventWaiting               ⇐                         "EnableEventWaiting"               _R⟨⟩                                              #                                                                   # Enable waiting for events on EndDrawing(), no automatic event polling
disableEventWaiting              ⇐                         "DisableEventWaiting"              _R⟨⟩                                              #                                                                   # Disable waiting for events on EndDrawing(), automatic events polling
showCursor                       ⇐                         "ShowCursor"                       _R⟨⟩                                              #                                                                   # Shows cursor
hideCursor                       ⇐                         "HideCursor"                       _R⟨⟩                                              #                                                                   # Hides cursor
isCursorHidden                   ⇐ bool                    "IsCursorHidden"                   _R⟨⟩                                              #                                                                   # Check if cursor is not visible
enableCursor                     ⇐                         "EnableCursor"                     _R⟨⟩                                              #                                                                   # Enables cursor (unlock cursor)
disableCursor                    ⇐                         "DisableCursor"                    _R⟨⟩                                              #                                                                   # Disables cursor (lock cursor)
isCursorOnScreen                 ⇐ bool                    "IsCursorOnScreen"                 _R⟨⟩                                              #                                                                   # Check if cursor is on the screen
clearBackground                  ⇐                         "ClearBackground"                  _R⟨color⟩                                         # color                                                             # Set background color (framebuffer clear color)
beginDrawing                     ⇐                         "BeginDrawing"                     _R⟨⟩                                              #                                                                   # Setup canvas (framebuffer) to start drawing
endDrawing                       ⇐                         "EndDrawing"                       _R⟨⟩                                              #                                                                   # End canvas drawing and swap buffers (double buffering)
beginMode2D                      ⇐                         "BeginMode2D"                      _R⟨camera2D⟩                                      # camera                                                            # Begin 2D mode with custom camera (2D)
endMode2D                        ⇐                         "EndMode2D"                        _R⟨⟩                                              #                                                                   # Ends 2D mode with custom camera
beginMode3D                      ⇐                         "BeginMode3D"                      _R⟨camera3D⟩                                      # camera                                                            # Begin 3D mode with custom camera (3D)
endMode3D                        ⇐                         "EndMode3D"                        _R⟨⟩                                              #                                                                   # Ends 3D mode and returns to default 2D orthographic mode
beginTextureMode                 ⇐                         "BeginTextureMode"                 _R⟨renderTexture2D⟩                               # target                                                            # Begin drawing to render texture
endTextureMode                   ⇐                         "EndTextureMode"                   _R⟨⟩                                              #                                                                   # Ends drawing to render texture
beginShaderMode                  ⇐                         "BeginShaderMode"                  _R⟨shader⟩                                        # shader                                                            # Begin custom shader drawing
endShaderMode                    ⇐                         "EndShaderMode"                    _R⟨⟩                                              #                                                                   # End custom shader drawing (use default shader)
beginBlendMode                   ⇐                         "BeginBlendMode"                   _R⟨i⟩                                             # mode                                                              # Begin blending mode (alpha, additive, multiplied, subtract, custom)
endBlendMode                     ⇐                         "EndBlendMode"                     _R⟨⟩                                              #                                                                   # End blending mode (reset to default: alpha blending)
beginScissorMode                 ⇐                         "BeginScissorMode"                 _R⟨i⋄i⋄i⋄i⟩                                       # x y width height                                                  # Begin scissor mode (define screen area for following drawing)
endScissorMode                   ⇐                         "EndScissorMode"                   _R⟨⟩                                              #                                                                   # End scissor mode
beginVrStereoMode                ⇐                         "BeginVrStereoMode"                _R⟨vrStereoConfig⟩                                # config                                                            # Begin stereo rendering (requires VR simulator)
endVrStereoMode                  ⇐                         "EndVrStereoMode"                  _R⟨⟩                                              #                                                                   # End stereo rendering (requires VR simulator)
loadVrStereoConfig               ⇐ vrStereoConfig          "LoadVrStereoConfig"               _R⟨vrDeviceInfo⟩                                  # device                                                            # Load VR stereo config for VR simulator device parameters
unloadVrStereoConfig             ⇐                         "UnloadVrStereoConfig"             _R⟨vrStereoConfig⟩                                # config                                                            # Unload VR stereo config
loadShader                       ⇐ shader                  "LoadShader"                       _R⟨str⋄str⟩                                       # vsFileName fsFileName                                             # Load shader from files and bind default locations
loadShaderFromMemory             ⇐ shader                  "LoadShaderFromMemory"             _R⟨str⋄str⟩                                       # vsCode fsCode                                                     # Load shader from code strings and bind default locations
isShaderReady                    ⇐ bool                    "IsShaderReady"                    _R⟨shader⟩                                        # shader                                                            # Check if a shader is ready
getShaderLocation                ⇐ i                       "GetShaderLocation"                _R⟨shader⋄str⟩                                    # shader uniformName                                                # Get shader uniform location
getShaderLocationAttrib          ⇐ i                       "GetShaderLocationAttrib"          _R⟨shader⋄str⟩                                    # shader attribName                                                 # Get shader attribute location
setShaderValue                   ⇐                         "SetShaderValue"                   _R⟨shader⋄i⋄ptr⋄i⟩                                # shader locIndex value uniformType                                 # Set shader uniform value
setShaderValueRaw                ⇐                         "SetShaderValue"                   _R⟨shader⋄i⋄"*i8"⋄i⟩                              # shader locIndex value uniformType                                 # Set shader uniform value
setShaderValueV                  ⇐                         "SetShaderValueV"                  _R⟨shader⋄i⋄ptr⋄i⋄i⟩                              # shader locIndex value uniformType count                           # Set shader uniform value vector
setShaderValueVRaw               ⇐                         "SetShaderValueV"                  _R⟨shader⋄i⋄"*i8"⋄i⋄i⟩                            # shader locIndex value uniformType count                           # Set shader uniform value vector
setShaderValueMatrix             ⇐                         "SetShaderValueMatrix"             _R⟨shader⋄i⋄matrix⟩                               # shader locIndex mat                                               # Set shader uniform value (matrix 4x4)
setShaderValueTexture            ⇐                         "SetShaderValueTexture"            _R⟨shader⋄i⋄texture2D⟩                            # shader locIndex texture                                           # Set shader uniform value for texture (sampler2d)
unloadShader                     ⇐                         "UnloadShader"                     _R⟨shader⟩                                        # shader                                                            # Unload shader from GPU memory (VRAM)
getMouseRay                      ⇐ ray                     "GetMouseRay"                      _R⟨v2⋄camera⟩                                     # mousePosition camera                                              # Get a ray trace from mouse position
getCameraMatrix                  ⇐ matrix                  "GetCameraMatrix"                  _R⟨camera⟩                                        # camera                                                            # Get camera transform matrix (view matrix)
getCameraMatrix2D                ⇐ matrix                  "GetCameraMatrix2D"                _R⟨camera2D⟩                                      # camera                                                            # Get camera 2d transform matrix
getWorldToScreen                 ⇐ v2                      "GetWorldToScreen"                 _R⟨v3⋄camera⟩                                     # position camera                                                   # Get the screen space position for a 3d world space position
getScreenToWorld2D               ⇐ v2                      "GetScreenToWorld2D"               _R⟨v2⋄camera2D⟩                                   # position camera                                                   # Get the world space position for a 2d camera screen space position
getWorldToScreenEx               ⇐ v2                      "GetWorldToScreenEx"               _R⟨v3⋄camera⋄i⋄i⟩                                 # position camera width height                                      # Get size position for a 3d world space position
getWorldToScreen2D               ⇐ v2                      "GetWorldToScreen2D"               _R⟨v2⋄camera2D⟩                                   # position camera                                                   # Get the screen space position for a 2d camera world space position
setTargetFPS                     ⇐                         "SetTargetFPS"                     _R⟨i⟩                                             # fps                                                               # Set target FPS (maximum)
getFrameTime                     ⇐ f                       "GetFrameTime"                     _R⟨⟩                                              #                                                                   # Get time in seconds for last frame drawn (delta time)
getTime                          ⇐ "f64"                   "GetTime"                          _R⟨⟩                                              #                                                                   # Get elapsed time in seconds since InitWindow()
getFPS                           ⇐ i                       "GetFPS"                           _R⟨⟩                                              #                                                                   # Get current FPS
swapScreenBuffer                 ⇐                         "SwapScreenBuffer"                 _R⟨⟩                                              #                                                                   # Swap back buffer with front buffer (screen drawing)
pollInputEvents                  ⇐                         "PollInputEvents"                  _R⟨⟩                                              #                                                                   # Register all input events
waitTime                         ⇐                         "WaitTime"                         _R⟨"f64"⟩                                         # seconds                                                           # Wait for some time (halt program execution)
setRandomSeed                    ⇐                         "SetRandomSeed"                    _R⟨u⟩                                             # seed                                                              # Set the seed for the random number generator
getRandomValue                   ⇐ i                       "GetRandomValue"                   _R⟨i⋄i⟩                                           # min max                                                           # Get a random value between min and max (both included)
loadRandomSequence               ⇐ (ptr⊣"*"∾i)             "LoadRandomSequence"               _R⟨u⋄i⋄i⟩                                         # count min max                                                     # Load random values sequence, no values repeated
unloadRandomSequence             ⇐                         "UnloadRandomSequence"             _R⟨"*"∾i⟩                                         # sequence                                                          # Unload random values sequence
unloadRandomSequenceRef          ⇐                         "UnloadRandomSequence"             _R⟨"&"∾i⟩                                         # sequence                                                          # Unload random values sequence
takeScreenshot                   ⇐                         "TakeScreenshot"                   _R⟨str⟩                                           # fileName                                                          # Takes a screenshot of current screen (filename extension defines format)
setConfigFlags                   ⇐                         "SetConfigFlags"                   _R⟨u⟩                                             # flags                                                             # Setup init configuration flags (view FLAGS)
openURL                          ⇐                         "OpenURL"                          _R⟨str⟩                                           # url                                                               # Open URL with default system browser (if available)
traceLog                         ⇐                         "TraceLog"                         _R⟨i⋄str⋄ptr⟩                                     # logLevel text args                                                # Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
setTraceLogLevel                 ⇐                         "SetTraceLogLevel"                 _R⟨i⟩                                             # logLevel                                                          # Set the current threshold (minimum) log level
memAlloc                         ⇐ ptr                     "MemAlloc"                         _R⟨u⟩                                             # size                                                              # Internal memory allocator
memRealloc                       ⇐ ptr                     "MemRealloc"                       _R⟨ptr⋄u⟩                                         # ptr size                                                          # Internal memory reallocator
memReallocRef                    ⇐ ptr                     "MemRealloc"                       _R⟨"&u8"⋄u⟩                                       # ptr size                                                          # Internal memory reallocator
memFree                          ⇐                         "MemFree"                          _R⟨ptr⟩                                           # ptr                                                               # Internal memory free
memFreeRef                       ⇐                         "MemFree"                          _R⟨"&u8"⟩                                         # ptr                                                               # Internal memory free
setTraceLogCallback              ⇐                         "SetTraceLogCallback"              _R⟨ptr⟩                                           # callback                                                          # Set custom trace log
setLoadFileDataCallback          ⇐                         "SetLoadFileDataCallback"          _R⟨ptr⟩                                           # callback                                                          # Set custom file binary data loader
setSaveFileDataCallback          ⇐                         "SetSaveFileDataCallback"          _R⟨ptr⟩                                           # callback                                                          # Set custom file binary data saver
setLoadFileTextCallback          ⇐                         "SetLoadFileTextCallback"          _R⟨ptr⟩                                           # callback                                                          # Set custom file text data loader
setSaveFileTextCallback          ⇐                         "SetSaveFileTextCallback"          _R⟨ptr⟩                                           # callback                                                          # Set custom file text data saver
loadFileData                     ⇐ (ptr⊣ustr)              "LoadFileData"                     _R⟨str⋄"*"∾i⟩                                     # fileName dataSize                                                 # Load file data as byte array (read)
loadFileDataRef                  ⇐ (ptr⊣ustr)              "LoadFileData"                     _R⟨str⋄"&"∾i⟩                                     # fileName dataSize                                                 # Load file data as byte array (read)
unloadFileData                   ⇐                         "UnloadFileData"                   _R⟨ustr⟩                                          # data                                                              # Unload file data allocated by LoadFileData()
unloadFileDataRef                ⇐                         "UnloadFileData"                   _R⟨"&u8"⟩                                         # data                                                              # Unload file data allocated by LoadFileData()
saveFileData                     ⇐ bool                    "SaveFileData"                     _R⟨str⋄ptr⋄i⟩                                     # fileName data dataSize                                            # Save data to file from byte array (write), returns true on success
saveFileDataRef                  ⇐ bool                    "SaveFileData"                     _R⟨str⋄"&u8"⋄i⟩                                   # fileName data dataSize                                            # Save data to file from byte array (write), returns true on success
exportDataAsCode                 ⇐ bool                    "ExportDataAsCode"                 _R⟨ustr⋄i⋄str⟩                                    # data dataSize fileName                                            # Export data to code (.h), returns true on success
loadFileText                     ⇐ (ptr⊣str)               "LoadFileText"                     _R⟨str⟩                                           # fileName                                                          # Load text data from file (read), returns a '\0' terminated string
unloadFileText                   ⇐                         "UnloadFileText"                   _R⟨str⟩                                           # text                                                              # Unload file text data allocated by LoadFileText()
unloadFileTextRef                ⇐                         "UnloadFileText"                   _R⟨"&u8:c8"⟩                                      # text                                                              # Unload file text data allocated by LoadFileText()
saveFileText                     ⇐ bool                    "SaveFileText"                     _R⟨str⋄str⟩                                       # fileName text                                                     # Save text data to file (write), string must be '\0' terminated, returns true on success
saveFileTextRef                  ⇐ bool                    "SaveFileText"                     _R⟨str⋄"&u8:c8"⟩                                  # fileName text                                                     # Save text data to file (write), string must be '\0' terminated, returns true on success
fileExists                       ⇐ bool                    "FileExists"                       _R⟨str⟩                                           # fileName                                                          # Check if file exists
directoryExists                  ⇐ bool                    "DirectoryExists"                  _R⟨str⟩                                           # dirPath                                                           # Check if a directory path exists
isFileExtension                  ⇐ bool                    "IsFileExtension"                  _R⟨str⋄str⟩                                       # fileName ext                                                      # Check file extension (including point: .png, .wav)
getFileLength                    ⇐ i                       "GetFileLength"                    _R⟨str⟩                                           # fileName                                                          # Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
getFileExtension                 ⇐ (ptr⊣str)               "GetFileExtension"                 _R⟨str⟩                                           # fileName                                                          # Get pointer to extension for a filename string (includes dot: '.png')
getFileName                      ⇐ (ptr⊣str)               "GetFileName"                      _R⟨str⟩                                           # filePath                                                          # Get pointer to filename for a path string
getFileNameWithoutExt            ⇐ (ptr⊣str)               "GetFileNameWithoutExt"            _R⟨str⟩                                           # filePath                                                          # Get filename string without extension (uses static string)
getDirectoryPath                 ⇐ (ptr⊣str)               "GetDirectoryPath"                 _R⟨str⟩                                           # filePath                                                          # Get full path for a given fileName with path (uses static string)
getPrevDirectoryPath             ⇐ (ptr⊣str)               "GetPrevDirectoryPath"             _R⟨str⟩                                           # dirPath                                                           # Get previous directory path for a given path (uses static string)
getWorkingDirectory              ⇐ (ptr⊣str)               "GetWorkingDirectory"              _R⟨⟩                                              #                                                                   # Get current working directory (uses static string)
getApplicationDirectory          ⇐ (ptr⊣str)               "GetApplicationDirectory"          _R⟨⟩                                              #                                                                   # Get the directory of the running application (uses static string)
changeDirectory                  ⇐ bool                    "ChangeDirectory"                  _R⟨str⟩                                           # dir                                                               # Change working directory, return true on success
isPathFile                       ⇐ bool                    "IsPathFile"                       _R⟨str⟩                                           # path                                                              # Check if a given path is a file or a directory
loadDirectoryFiles               ⇐ filePathList            "LoadDirectoryFiles"               _R⟨str⟩                                           # dirPath                                                           # Load directory filepaths
loadDirectoryFilesEx             ⇐ filePathList            "LoadDirectoryFilesEx"             _R⟨str⋄str⋄bool⟩                                  # basePath filter scanSubdirs                                       # Load directory filepaths with extension filtering and recursive directory scan
unloadDirectoryFiles             ⇐                         "UnloadDirectoryFiles"             _R⟨filePathList⟩                                  # files                                                             # Unload filepaths
isFileDropped                    ⇐ bool                    "IsFileDropped"                    _R⟨⟩                                              #                                                                   # Check if a file has been dropped into window
loadDroppedFiles                 ⇐ filePathList            "LoadDroppedFiles"                 _R⟨⟩                                              #                                                                   # Load dropped filepaths
unloadDroppedFiles               ⇐                         "UnloadDroppedFiles"               _R⟨filePathList⟩                                  # files                                                             # Unload dropped filepaths
getFileModTime                   ⇐ "i64"                   "GetFileModTime"                   _R⟨str⟩                                           # fileName                                                          # Get file modification time (last write time)
compressData                     ⇐ (ptr⊣ustr)              "CompressData"                     _R⟨ustr⋄i⋄"*"∾i⟩                                  # data dataSize compDataSize                                        # Compress data (DEFLATE algorithm), memory must be MemFree()
compressDataRef                  ⇐ (ptr⊣ustr)              "CompressData"                     _R⟨ustr⋄i⋄"&"∾i⟩                                  # data dataSize compDataSize                                        # Compress data (DEFLATE algorithm), memory must be MemFree()
decompressData                   ⇐ (ptr⊣ustr)              "DecompressData"                   _R⟨ustr⋄i⋄"*"∾i⟩                                  # compData compDataSize dataSize                                    # Decompress data (DEFLATE algorithm), memory must be MemFree()
decompressDataRef                ⇐ (ptr⊣ustr)              "DecompressData"                   _R⟨ustr⋄i⋄"&"∾i⟩                                  # compData compDataSize dataSize                                    # Decompress data (DEFLATE algorithm), memory must be MemFree()
encodeDataBase64                 ⇐ (ptr⊣str)               "EncodeDataBase64"                 _R⟨ustr⋄i⋄"*"∾i⟩                                  # data dataSize outputSize                                          # Encode data to Base64 string, memory must be MemFree()
encodeDataBase64Ref              ⇐ (ptr⊣str)               "EncodeDataBase64"                 _R⟨ustr⋄i⋄"&"∾i⟩                                  # data dataSize outputSize                                          # Encode data to Base64 string, memory must be MemFree()
decodeDataBase64                 ⇐ (ptr⊣ustr)              "DecodeDataBase64"                 _R⟨ustr⋄"*"∾i⟩                                    # data outputSize                                                   # Decode Base64 string data, memory must be MemFree()
decodeDataBase64Ref              ⇐ (ptr⊣ustr)              "DecodeDataBase64"                 _R⟨ustr⋄"&"∾i⟩                                    # data outputSize                                                   # Decode Base64 string data, memory must be MemFree()
loadAutomationEventList          ⇐ automationEventList     "LoadAutomationEventList"          _R⟨str⟩                                           # fileName                                                          # Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS
unloadAutomationEventList        ⇐                         "UnloadAutomationEventList"        _R⟨"*"∾automationEventList⟩                       # list                                                              # Unload automation events list from file
unloadAutomationEventListRef     ⇐                         "UnloadAutomationEventList"        _R⟨"&"∾automationEventList⟩                       # list                                                              # Unload automation events list from file
exportAutomationEventList        ⇐ bool                    "ExportAutomationEventList"        _R⟨automationEventList⋄str⟩                       # list fileName                                                     # Export automation events list as text file
setAutomationEventList           ⇐                         "SetAutomationEventList"           _R⟨"*"∾automationEventList⟩                       # list                                                              # Set automation event list to record to
setAutomationEventListRef        ⇐                         "SetAutomationEventList"           _R⟨"&"∾automationEventList⟩                       # list                                                              # Set automation event list to record to
setAutomationEventBaseFrame      ⇐                         "SetAutomationEventBaseFrame"      _R⟨i⟩                                             # frame                                                             # Set automation event internal base frame to start recording
startAutomationEventRecording    ⇐                         "StartAutomationEventRecording"    _R⟨⟩                                              #                                                                   # Start recording automation events (AutomationEventList must be set)
stopAutomationEventRecording     ⇐                         "StopAutomationEventRecording"     _R⟨⟩                                              #                                                                   # Stop recording automation events
playAutomationEvent              ⇐                         "PlayAutomationEvent"              _R⟨automationEvent⟩                               # event                                                             # Play a recorded automation event
isKeyPressed                     ⇐ bool                    "IsKeyPressed"                     _R⟨i⟩                                             # key                                                               # Check if a key has been pressed once
isKeyPressedRepeat               ⇐ bool                    "IsKeyPressedRepeat"               _R⟨i⟩                                             # key                                                               # Check if a key has been pressed again (Only PLATFORM_DESKTOP)
isKeyDown                        ⇐ bool                    "IsKeyDown"                        _R⟨i⟩                                             # key                                                               # Check if a key is being pressed
isKeyReleased                    ⇐ bool                    "IsKeyReleased"                    _R⟨i⟩                                             # key                                                               # Check if a key has been released once
isKeyUp                          ⇐ bool                    "IsKeyUp"                          _R⟨i⟩                                             # key                                                               # Check if a key is NOT being pressed
getKeyPressed                    ⇐ i                       "GetKeyPressed"                    _R⟨⟩                                              #                                                                   # Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
getCharPressed                   ⇐ i                       "GetCharPressed"                   _R⟨⟩                                              #                                                                   # Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
setExitKey                       ⇐                         "SetExitKey"                       _R⟨i⟩                                             # key                                                               # Set a custom key to exit program (default is ESC)
isGamepadAvailable               ⇐ bool                    "IsGamepadAvailable"               _R⟨i⟩                                             # gamepad                                                           # Check if a gamepad is available
getGamepadName                   ⇐ (ptr⊣str)               "GetGamepadName"                   _R⟨i⟩                                             # gamepad                                                           # Get gamepad internal name id
isGamepadButtonPressed           ⇐ bool                    "IsGamepadButtonPressed"           _R⟨i⋄i⟩                                           # gamepad button                                                    # Check if a gamepad button has been pressed once
isGamepadButtonDown              ⇐ bool                    "IsGamepadButtonDown"              _R⟨i⋄i⟩                                           # gamepad button                                                    # Check if a gamepad button is being pressed
isGamepadButtonReleased          ⇐ bool                    "IsGamepadButtonReleased"          _R⟨i⋄i⟩                                           # gamepad button                                                    # Check if a gamepad button has been released once
isGamepadButtonUp                ⇐ bool                    "IsGamepadButtonUp"                _R⟨i⋄i⟩                                           # gamepad button                                                    # Check if a gamepad button is NOT being pressed
getGamepadButtonPressed          ⇐ i                       "GetGamepadButtonPressed"          _R⟨⟩                                              #                                                                   # Get the last gamepad button pressed
getGamepadAxisCount              ⇐ i                       "GetGamepadAxisCount"              _R⟨i⟩                                             # gamepad                                                           # Get gamepad axis count for a gamepad
getGamepadAxisMovement           ⇐ f                       "GetGamepadAxisMovement"           _R⟨i⋄i⟩                                           # gamepad axis                                                      # Get axis movement value for a gamepad axis
setGamepadMappings               ⇐ i                       "SetGamepadMappings"               _R⟨str⟩                                           # mappings                                                          # Set internal gamepad mappings (SDL_GameControllerDB)
isMouseButtonPressed             ⇐ bool                    "IsMouseButtonPressed"             _R⟨i⟩                                             # button                                                            # Check if a mouse button has been pressed once
isMouseButtonDown                ⇐ bool                    "IsMouseButtonDown"                _R⟨i⟩                                             # button                                                            # Check if a mouse button is being pressed
isMouseButtonReleased            ⇐ bool                    "IsMouseButtonReleased"            _R⟨i⟩                                             # button                                                            # Check if a mouse button has been released once
isMouseButtonUp                  ⇐ bool                    "IsMouseButtonUp"                  _R⟨i⟩                                             # button                                                            # Check if a mouse button is NOT being pressed
getMouseX                        ⇐ i                       "GetMouseX"                        _R⟨⟩                                              #                                                                   # Get mouse position X
getMouseY                        ⇐ i                       "GetMouseY"                        _R⟨⟩                                              #                                                                   # Get mouse position Y
getMousePosition                 ⇐ v2                      "GetMousePosition"                 _R⟨⟩                                              #                                                                   # Get mouse position XY
getMouseDelta                    ⇐ v2                      "GetMouseDelta"                    _R⟨⟩                                              #                                                                   # Get mouse delta between frames
setMousePosition                 ⇐                         "SetMousePosition"                 _R⟨i⋄i⟩                                           # x y                                                               # Set mouse position XY
setMouseOffset                   ⇐                         "SetMouseOffset"                   _R⟨i⋄i⟩                                           # offsetX offsetY                                                   # Set mouse offset
setMouseScale                    ⇐                         "SetMouseScale"                    _R⟨f⋄f⟩                                           # scaleX scaleY                                                     # Set mouse scaling
getMouseWheelMove                ⇐ f                       "GetMouseWheelMove"                _R⟨⟩                                              #                                                                   # Get mouse wheel movement for X or Y, whichever is larger
getMouseWheelMoveV               ⇐ v2                      "GetMouseWheelMoveV"               _R⟨⟩                                              #                                                                   # Get mouse wheel movement for both X and Y
setMouseCursor                   ⇐                         "SetMouseCursor"                   _R⟨i⟩                                             # cursor                                                            # Set mouse cursor
getTouchX                        ⇐ i                       "GetTouchX"                        _R⟨⟩                                              #                                                                   # Get touch position X for touch point 0 (relative to screen size)
getTouchY                        ⇐ i                       "GetTouchY"                        _R⟨⟩                                              #                                                                   # Get touch position Y for touch point 0 (relative to screen size)
getTouchPosition                 ⇐ v2                      "GetTouchPosition"                 _R⟨i⟩                                             # index                                                             # Get touch position XY for a touch point index (relative to screen size)
getTouchPointId                  ⇐ i                       "GetTouchPointId"                  _R⟨i⟩                                             # index                                                             # Get touch point identifier for given index
getTouchPointCount               ⇐ i                       "GetTouchPointCount"               _R⟨⟩                                              #                                                                   # Get number of touch points
setGesturesEnabled               ⇐                         "SetGesturesEnabled"               _R⟨u⟩                                             # flags                                                             # Enable a set of gestures using flags
isGestureDetected                ⇐ bool                    "IsGestureDetected"                _R⟨u⟩                                             # gesture                                                           # Check if a gesture have been detected
getGestureDetected               ⇐ i                       "GetGestureDetected"               _R⟨⟩                                              #                                                                   # Get latest detected gesture
getGestureHoldDuration           ⇐ f                       "GetGestureHoldDuration"           _R⟨⟩                                              #                                                                   # Get gesture hold time in milliseconds
getGestureDragVector             ⇐ v2                      "GetGestureDragVector"             _R⟨⟩                                              #                                                                   # Get gesture drag vector
getGestureDragAngle              ⇐ f                       "GetGestureDragAngle"              _R⟨⟩                                              #                                                                   # Get gesture drag angle
getGesturePinchVector            ⇐ v2                      "GetGesturePinchVector"            _R⟨⟩                                              #                                                                   # Get gesture pinch delta
getGesturePinchAngle             ⇐ f                       "GetGesturePinchAngle"             _R⟨⟩                                              #                                                                   # Get gesture pinch angle
updateCamera                     ⇐                         "UpdateCamera"                     _R⟨"*"∾camera⋄i⟩                                  # camera mode                                                       # Update camera position for selected mode
updateCameraRef                  ⇐                         "UpdateCamera"                     _R⟨"&"∾camera⋄i⟩                                  # camera mode                                                       # Update camera position for selected mode
updateCameraPro                  ⇐                         "UpdateCameraPro"                  _R⟨"*"∾camera⋄v3⋄v3⋄f⟩                            # camera movement rotation zoom                                     # Update camera movement/rotation
updateCameraProRef               ⇐                         "UpdateCameraPro"                  _R⟨"&"∾camera⋄v3⋄v3⋄f⟩                            # camera movement rotation zoom                                     # Update camera movement/rotation
setShapesTexture                 ⇐                         "SetShapesTexture"                 _R⟨texture2D⋄rectangle⟩                           # texture source                                                    # Set texture and rectangle to be used on shapes drawing
drawPixel                        ⇐                         "DrawPixel"                        _R⟨i⋄i⋄color⟩                                     # posX posY color                                                   # Draw a pixel
drawPixelV                       ⇐                         "DrawPixelV"                       _R⟨v2⋄color⟩                                      # position color                                                    # Draw a pixel (Vector version)
drawLine                         ⇐                         "DrawLine"                         _R⟨i⋄i⋄i⋄i⋄color⟩                                 # startPosX startPosY endPosX endPosY color                         # Draw a line
drawLineV                        ⇐                         "DrawLineV"                        _R⟨v2⋄v2⋄color⟩                                   # startPos endPos color                                             # Draw a line (using gl lines)
drawLineEx                       ⇐                         "DrawLineEx"                       _R⟨v2⋄v2⋄f⋄color⟩                                 # startPos endPos thick color                                       # Draw a line (using triangles/quads)
drawLineStrip                    ⇐                         "DrawLineStrip"                    _R⟨"*"∾v2⋄i⋄color⟩                                # points pointCount color                                           # Draw lines sequence (using gl lines)
drawLineStripRef                 ⇐                         "DrawLineStrip"                    _R⟨"&"∾v2⋄i⋄color⟩                                # points pointCount color                                           # Draw lines sequence (using gl lines)
drawLineBezier                   ⇐                         "DrawLineBezier"                   _R⟨v2⋄v2⋄f⋄color⟩                                 # startPos endPos thick color                                       # Draw line segment cubic-bezier in-out interpolation
drawCircle                       ⇐                         "DrawCircle"                       _R⟨i⋄i⋄f⋄color⟩                                   # centerX centerY radius color                                      # Draw a color-filled circle
drawCircleSector                 ⇐                         "DrawCircleSector"                 _R⟨v2⋄f⋄f⋄f⋄i⋄color⟩                              # center radius startAngle endAngle segments color                  # Draw a piece of a circle
drawCircleSectorLines            ⇐                         "DrawCircleSectorLines"            _R⟨v2⋄f⋄f⋄f⋄i⋄color⟩                              # center radius startAngle endAngle segments color                  # Draw circle sector outline
drawCircleGradient               ⇐                         "DrawCircleGradient"               _R⟨i⋄i⋄f⋄color⋄color⟩                             # centerX centerY radius color1 color2                              # Draw a gradient-filled circle
drawCircleV                      ⇐                         "DrawCircleV"                      _R⟨v2⋄f⋄color⟩                                    # center radius color                                               # Draw a color-filled circle (Vector version)
drawCircleLines                  ⇐                         "DrawCircleLines"                  _R⟨i⋄i⋄f⋄color⟩                                   # centerX centerY radius color                                      # Draw circle outline
drawCircleLinesV                 ⇐                         "DrawCircleLinesV"                 _R⟨v2⋄f⋄color⟩                                    # center radius color                                               # Draw circle outline (Vector version)
drawEllipse                      ⇐                         "DrawEllipse"                      _R⟨i⋄i⋄f⋄f⋄color⟩                                 # centerX centerY radiusH radiusV color                             # Draw ellipse
drawEllipseLines                 ⇐                         "DrawEllipseLines"                 _R⟨i⋄i⋄f⋄f⋄color⟩                                 # centerX centerY radiusH radiusV color                             # Draw ellipse outline
drawRing                         ⇐                         "DrawRing"                         _R⟨v2⋄f⋄f⋄f⋄f⋄i⋄color⟩                            # center innerRadius outerRadius startAngle endAngle segments color # Draw ring
drawRingLines                    ⇐                         "DrawRingLines"                    _R⟨v2⋄f⋄f⋄f⋄f⋄i⋄color⟩                            # center innerRadius outerRadius startAngle endAngle segments color # Draw ring outline
drawRectangle                    ⇐                         "DrawRectangle"                    _R⟨i⋄i⋄i⋄i⋄color⟩                                 # posX posY width height color                                      # Draw a color-filled rectangle
drawRectangleV                   ⇐                         "DrawRectangleV"                   _R⟨v2⋄v2⋄color⟩                                   # position size color                                               # Draw a color-filled rectangle (Vector version)
drawRectangleRec                 ⇐                         "DrawRectangleRec"                 _R⟨rectangle⋄color⟩                               # rec color                                                         # Draw a color-filled rectangle
drawRectanglePro                 ⇐                         "DrawRectanglePro"                 _R⟨rectangle⋄v2⋄f⋄color⟩                          # rec origin rotation color                                         # Draw a color-filled rectangle with pro parameters
drawRectangleGradientV           ⇐                         "DrawRectangleGradientV"           _R⟨i⋄i⋄i⋄i⋄color⋄color⟩                           # posX posY width height color1 color2                              # Draw a vertical-gradient-filled rectangle
drawRectangleGradientH           ⇐                         "DrawRectangleGradientH"           _R⟨i⋄i⋄i⋄i⋄color⋄color⟩                           # posX posY width height color1 color2                              # Draw a horizontal-gradient-filled rectangle
drawRectangleGradientEx          ⇐                         "DrawRectangleGradientEx"          _R⟨rectangle⋄color⋄color⋄color⋄color⟩             # rec col1 col2 col3 col4                                           # Draw a gradient-filled rectangle with custom vertex colors
drawRectangleLines               ⇐                         "DrawRectangleLines"               _R⟨i⋄i⋄i⋄i⋄color⟩                                 # posX posY width height color                                      # Draw rectangle outline
drawRectangleLinesEx             ⇐                         "DrawRectangleLinesEx"             _R⟨rectangle⋄f⋄color⟩                             # rec lineThick color                                               # Draw rectangle outline with extended parameters
drawRectangleRounded             ⇐                         "DrawRectangleRounded"             _R⟨rectangle⋄f⋄i⋄color⟩                           # rec roundness segments color                                      # Draw rectangle with rounded edges
drawRectangleRoundedLines        ⇐                         "DrawRectangleRoundedLines"        _R⟨rectangle⋄f⋄i⋄f⋄color⟩                         # rec roundness segments lineThick color                            # Draw rectangle with rounded edges outline
drawTriangle                     ⇐                         "DrawTriangle"                     _R⟨v2⋄v2⋄v2⋄color⟩                                # v1 v2 v3 color                                                    # Draw a color-filled triangle (vertex in counter-clockwise order!)
drawTriangleLines                ⇐                         "DrawTriangleLines"                _R⟨v2⋄v2⋄v2⋄color⟩                                # v1 v2 v3 color                                                    # Draw triangle outline (vertex in counter-clockwise order!)
drawTriangleFan                  ⇐                         "DrawTriangleFan"                  _R⟨"*"∾v2⋄i⋄color⟩                                # points pointCount color                                           # Draw a triangle fan defined by points (first vertex is the center)
drawTriangleFanRef               ⇐                         "DrawTriangleFan"                  _R⟨"&"∾v2⋄i⋄color⟩                                # points pointCount color                                           # Draw a triangle fan defined by points (first vertex is the center)
drawTriangleStrip                ⇐                         "DrawTriangleStrip"                _R⟨"*"∾v2⋄i⋄color⟩                                # points pointCount color                                           # Draw a triangle strip defined by points
drawTriangleStripRef             ⇐                         "DrawTriangleStrip"                _R⟨"&"∾v2⋄i⋄color⟩                                # points pointCount color                                           # Draw a triangle strip defined by points
drawPoly                         ⇐                         "DrawPoly"                         _R⟨v2⋄i⋄f⋄f⋄color⟩                                # center sides radius rotation color                                # Draw a regular polygon (Vector version)
drawPolyLines                    ⇐                         "DrawPolyLines"                    _R⟨v2⋄i⋄f⋄f⋄color⟩                                # center sides radius rotation color                                # Draw a polygon outline of n sides
drawPolyLinesEx                  ⇐                         "DrawPolyLinesEx"                  _R⟨v2⋄i⋄f⋄f⋄f⋄color⟩                              # center sides radius rotation lineThick color                      # Draw a polygon outline of n sides with extended parameters
drawSplineLinear                 ⇐                         "DrawSplineLinear"                 _R⟨"*"∾v2⋄i⋄f⋄color⟩                              # points pointCount thick color                                     # Draw spline: Linear, minimum 2 points
drawSplineLinearRef              ⇐                         "DrawSplineLinear"                 _R⟨"&"∾v2⋄i⋄f⋄color⟩                              # points pointCount thick color                                     # Draw spline: Linear, minimum 2 points
drawSplineBasis                  ⇐                         "DrawSplineBasis"                  _R⟨"*"∾v2⋄i⋄f⋄color⟩                              # points pointCount thick color                                     # Draw spline: B-Spline, minimum 4 points
drawSplineBasisRef               ⇐                         "DrawSplineBasis"                  _R⟨"&"∾v2⋄i⋄f⋄color⟩                              # points pointCount thick color                                     # Draw spline: B-Spline, minimum 4 points
drawSplineCatmullRom             ⇐                         "DrawSplineCatmullRom"             _R⟨"*"∾v2⋄i⋄f⋄color⟩                              # points pointCount thick color                                     # Draw spline: Catmull-Rom, minimum 4 points
drawSplineCatmullRomRef          ⇐                         "DrawSplineCatmullRom"             _R⟨"&"∾v2⋄i⋄f⋄color⟩                              # points pointCount thick color                                     # Draw spline: Catmull-Rom, minimum 4 points
drawSplineBezierQuadratic        ⇐                         "DrawSplineBezierQuadratic"        _R⟨"*"∾v2⋄i⋄f⋄color⟩                              # points pointCount thick color                                     # Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]
drawSplineBezierQuadraticRef     ⇐                         "DrawSplineBezierQuadratic"        _R⟨"&"∾v2⋄i⋄f⋄color⟩                              # points pointCount thick color                                     # Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]
drawSplineBezierCubic            ⇐                         "DrawSplineBezierCubic"            _R⟨"*"∾v2⋄i⋄f⋄color⟩                              # points pointCount thick color                                     # Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]
drawSplineBezierCubicRef         ⇐                         "DrawSplineBezierCubic"            _R⟨"&"∾v2⋄i⋄f⋄color⟩                              # points pointCount thick color                                     # Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]
drawSplineSegmentLinear          ⇐                         "DrawSplineSegmentLinear"          _R⟨v2⋄v2⋄f⋄color⟩                                 # p1 p2 thick color                                                 # Draw spline segment: Linear, 2 points
drawSplineSegmentBasis           ⇐                         "DrawSplineSegmentBasis"           _R⟨v2⋄v2⋄v2⋄v2⋄f⋄color⟩                           # p1 p2 p3 p4 thick color                                           # Draw spline segment: B-Spline, 4 points
drawSplineSegmentCatmullRom      ⇐                         "DrawSplineSegmentCatmullRom"      _R⟨v2⋄v2⋄v2⋄v2⋄f⋄color⟩                           # p1 p2 p3 p4 thick color                                           # Draw spline segment: Catmull-Rom, 4 points
drawSplineSegmentBezierQuadratic ⇐                         "DrawSplineSegmentBezierQuadratic" _R⟨v2⋄v2⋄v2⋄f⋄color⟩                              # p1 c2 p3 thick color                                              # Draw spline segment: Quadratic Bezier, 2 points, 1 control point
drawSplineSegmentBezierCubic     ⇐                         "DrawSplineSegmentBezierCubic"     _R⟨v2⋄v2⋄v2⋄v2⋄f⋄color⟩                           # p1 c2 c3 p4 thick color                                           # Draw spline segment: Cubic Bezier, 2 points, 2 control points
getSplinePointLinear             ⇐ v2                      "GetSplinePointLinear"             _R⟨v2⋄v2⋄f⟩                                       # startPos endPos t                                                 # Get (evaluate) spline point: Linear
getSplinePointBasis              ⇐ v2                      "GetSplinePointBasis"              _R⟨v2⋄v2⋄v2⋄v2⋄f⟩                                 # p1 p2 p3 p4 t                                                     # Get (evaluate) spline point: B-Spline
getSplinePointCatmullRom         ⇐ v2                      "GetSplinePointCatmullRom"         _R⟨v2⋄v2⋄v2⋄v2⋄f⟩                                 # p1 p2 p3 p4 t                                                     # Get (evaluate) spline point: Catmull-Rom
getSplinePointBezierQuad         ⇐ v2                      "GetSplinePointBezierQuad"         _R⟨v2⋄v2⋄v2⋄f⟩                                    # p1 c2 p3 t                                                        # Get (evaluate) spline point: Quadratic Bezier
getSplinePointBezierCubic        ⇐ v2                      "GetSplinePointBezierCubic"        _R⟨v2⋄v2⋄v2⋄v2⋄f⟩                                 # p1 c2 c3 p4 t                                                     # Get (evaluate) spline point: Cubic Bezier
checkCollisionRecs               ⇐ bool                    "CheckCollisionRecs"               _R⟨rectangle⋄rectangle⟩                           # rec1 rec2                                                         # Check collision between two rectangles
checkCollisionCircles            ⇐ bool                    "CheckCollisionCircles"            _R⟨v2⋄f⋄v2⋄f⟩                                     # center1 radius1 center2 radius2                                   # Check collision between two circles
checkCollisionCircleRec          ⇐ bool                    "CheckCollisionCircleRec"          _R⟨v2⋄f⋄rectangle⟩                                # center radius rec                                                 # Check collision between circle and rectangle
checkCollisionPointRec           ⇐ bool                    "CheckCollisionPointRec"           _R⟨v2⋄rectangle⟩                                  # point rec                                                         # Check if point is inside rectangle
checkCollisionPointCircle        ⇐ bool                    "CheckCollisionPointCircle"        _R⟨v2⋄v2⋄f⟩                                       # point center radius                                               # Check if point is inside circle
checkCollisionPointTriangle      ⇐ bool                    "CheckCollisionPointTriangle"      _R⟨v2⋄v2⋄v2⋄v2⟩                                   # point p1 p2 p3                                                    # Check if point is inside a triangle
checkCollisionPointPoly          ⇐ bool                    "CheckCollisionPointPoly"          _R⟨v2⋄"*"∾v2⋄i⟩                                   # point points pointCount                                           # Check if point is within a polygon described by array of vertices
checkCollisionPointPolyRef       ⇐ bool                    "CheckCollisionPointPoly"          _R⟨v2⋄"&"∾v2⋄i⟩                                   # point points pointCount                                           # Check if point is within a polygon described by array of vertices
checkCollisionLines              ⇐ bool                    "CheckCollisionLines"              _R⟨v2⋄v2⋄v2⋄v2⋄"*"∾v2⟩                            # startPos1 endPos1 startPos2 endPos2 collisionPoint                # Check the collision between two lines defined by two points each, returns collision point by reference
checkCollisionLinesRef           ⇐ bool                    "CheckCollisionLines"              _R⟨v2⋄v2⋄v2⋄v2⋄"&"∾v2⟩                            # startPos1 endPos1 startPos2 endPos2 collisionPoint                # Check the collision between two lines defined by two points each, returns collision point by reference
checkCollisionPointLine          ⇐ bool                    "CheckCollisionPointLine"          _R⟨v2⋄v2⋄v2⋄i⟩                                    # point p1 p2 threshold                                             # Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
getCollisionRec                  ⇐ rectangle               "GetCollisionRec"                  _R⟨rectangle⋄rectangle⟩                           # rec1 rec2                                                         # Get collision rectangle for two rectangles collision
loadImage                        ⇐ image                   "LoadImage"                        _R⟨str⟩                                           # fileName                                                          # Load image from file into CPU memory (RAM)
loadImageRaw                     ⇐ image                   "LoadImageRaw"                     _R⟨str⋄i⋄i⋄i⋄i⟩                                   # fileName width height format headerSize                           # Load image from RAW file data
loadImageSvg                     ⇐ image                   "LoadImageSvg"                     _R⟨str⋄i⋄i⟩                                       # fileNameOrString width height                                     # Load image from SVG file data or string with specified size
loadImageAnim                    ⇐ image                   "LoadImageAnim"                    _R⟨str⋄"*"∾i⟩                                     # fileName frames                                                   # Load image sequence from file (frames appended to image.data)
loadImageAnimRef                 ⇐ image                   "LoadImageAnim"                    _R⟨str⋄"&"∾i⟩                                     # fileName frames                                                   # Load image sequence from file (frames appended to image.data)
loadImageFromMemory              ⇐ image                   "LoadImageFromMemory"              _R⟨str⋄ustr⋄i⟩                                    # fileType fileData dataSize                                        # Load image from memory buffer, fileType refers to extension: i.e. '.png'
loadImageFromTexture             ⇐ image                   "LoadImageFromTexture"             _R⟨texture2D⟩                                     # texture                                                           # Load image from GPU texture data
loadImageFromScreen              ⇐ image                   "LoadImageFromScreen"              _R⟨⟩                                              #                                                                   # Load image from screen buffer and (screenshot)
isImageReady                     ⇐ bool                    "IsImageReady"                     _R⟨image⟩                                         # image                                                             # Check if an image is ready
unloadImage                      ⇐                         "UnloadImage"                      _R⟨image⟩                                         # image                                                             # Unload image from CPU memory (RAM)
exportImage                      ⇐ bool                    "ExportImage"                      _R⟨image⋄str⟩                                     # image fileName                                                    # Export image data to file, returns true on success
exportImageToMemory              ⇐ (ptr⊣ustr)              "ExportImageToMemory"              _R⟨image⋄str⋄"*"∾i⟩                               # image fileType fileSize                                           # Export image to memory buffer
exportImageToMemoryRef           ⇐ (ptr⊣ustr)              "ExportImageToMemory"              _R⟨image⋄str⋄"&"∾i⟩                               # image fileType fileSize                                           # Export image to memory buffer
exportImageAsCode                ⇐ bool                    "ExportImageAsCode"                _R⟨image⋄str⟩                                     # image fileName                                                    # Export image as code file defining an array of bytes, returns true on success
genImageColor                    ⇐ image                   "GenImageColor"                    _R⟨i⋄i⋄color⟩                                     # width height color                                                # Generate image: plain color
genImageGradientLinear           ⇐ image                   "GenImageGradientLinear"           _R⟨i⋄i⋄i⋄color⋄color⟩                             # width height direction start end                                  # Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient
genImageGradientRadial           ⇐ image                   "GenImageGradientRadial"           _R⟨i⋄i⋄f⋄color⋄color⟩                             # width height density inner outer                                  # Generate image: radial gradient
genImageGradientSquare           ⇐ image                   "GenImageGradientSquare"           _R⟨i⋄i⋄f⋄color⋄color⟩                             # width height density inner outer                                  # Generate image: square gradient
genImageChecked                  ⇐ image                   "GenImageChecked"                  _R⟨i⋄i⋄i⋄i⋄color⋄color⟩                           # width height checksX checksY col1 col2                            # Generate image: checked
genImageWhiteNoise               ⇐ image                   "GenImageWhiteNoise"               _R⟨i⋄i⋄f⟩                                         # width height factor                                               # Generate image: white noise
genImagePerlinNoise              ⇐ image                   "GenImagePerlinNoise"              _R⟨i⋄i⋄i⋄i⋄f⟩                                     # width height offsetX offsetY scale                                # Generate image: perlin noise
genImageCellular                 ⇐ image                   "GenImageCellular"                 _R⟨i⋄i⋄i⟩                                         # width height tileSize                                             # Generate image: cellular algorithm, bigger tileSize means bigger cells
genImageText                     ⇐ image                   "GenImageText"                     _R⟨i⋄i⋄str⟩                                       # width height text                                                 # Generate image: grayscale image from text data
imageCopy                        ⇐ image                   "ImageCopy"                        _R⟨image⟩                                         # image                                                             # Create an image duplicate (useful for transformations)
imageFromImage                   ⇐ image                   "ImageFromImage"                   _R⟨image⋄rectangle⟩                               # image rec                                                         # Create an image from another image piece
imageText                        ⇐ image                   "ImageText"                        _R⟨str⋄i⋄color⟩                                   # text fontSize color                                               # Create an image from text (default font)
imageTextEx                      ⇐ image                   "ImageTextEx"                      _R⟨font⋄str⋄f⋄f⋄color⟩                            # font text fontSize spacing tint                                   # Create an image from text (custom sprite font)
imageFormat                      ⇐                         "ImageFormat"                      _R⟨"*"∾image⋄i⟩                                   # image newFormat                                                   # Convert image data to desired format
imageFormatRef                   ⇐                         "ImageFormat"                      _R⟨"&"∾image⋄i⟩                                   # image newFormat                                                   # Convert image data to desired format
imageToPOT                       ⇐                         "ImageToPOT"                       _R⟨"*"∾image⋄color⟩                               # image fill                                                        # Convert image to POT (power-of-two)
imageToPOTRef                    ⇐                         "ImageToPOT"                       _R⟨"&"∾image⋄color⟩                               # image fill                                                        # Convert image to POT (power-of-two)
imageCrop                        ⇐                         "ImageCrop"                        _R⟨"*"∾image⋄rectangle⟩                           # image crop                                                        # Crop an image to a defined rectangle
imageCropRef                     ⇐                         "ImageCrop"                        _R⟨"&"∾image⋄rectangle⟩                           # image crop                                                        # Crop an image to a defined rectangle
imageAlphaCrop                   ⇐                         "ImageAlphaCrop"                   _R⟨"*"∾image⋄f⟩                                   # image threshold                                                   # Crop image depending on alpha value
imageAlphaCropRef                ⇐                         "ImageAlphaCrop"                   _R⟨"&"∾image⋄f⟩                                   # image threshold                                                   # Crop image depending on alpha value
imageAlphaClear                  ⇐                         "ImageAlphaClear"                  _R⟨"*"∾image⋄color⋄f⟩                             # image color threshold                                             # Clear alpha channel to desired color
imageAlphaClearRef               ⇐                         "ImageAlphaClear"                  _R⟨"&"∾image⋄color⋄f⟩                             # image color threshold                                             # Clear alpha channel to desired color
imageAlphaMask                   ⇐                         "ImageAlphaMask"                   _R⟨"*"∾image⋄image⟩                               # image alphaMask                                                   # Apply alpha mask to image
imageAlphaMaskRef                ⇐                         "ImageAlphaMask"                   _R⟨"&"∾image⋄image⟩                               # image alphaMask                                                   # Apply alpha mask to image
imageAlphaPremultiply            ⇐                         "ImageAlphaPremultiply"            _R⟨"*"∾image⟩                                     # image                                                             # Premultiply alpha channel
imageAlphaPremultiplyRef         ⇐                         "ImageAlphaPremultiply"            _R⟨"&"∾image⟩                                     # image                                                             # Premultiply alpha channel
imageBlurGaussian                ⇐                         "ImageBlurGaussian"                _R⟨"*"∾image⋄i⟩                                   # image blurSize                                                    # Apply Gaussian blur using a box blur approximation
imageBlurGaussianRef             ⇐                         "ImageBlurGaussian"                _R⟨"&"∾image⋄i⟩                                   # image blurSize                                                    # Apply Gaussian blur using a box blur approximation
imageResize                      ⇐                         "ImageResize"                      _R⟨"*"∾image⋄i⋄i⟩                                 # image newWidth newHeight                                          # Resize image (Bicubic scaling algorithm)
imageResizeRef                   ⇐                         "ImageResize"                      _R⟨"&"∾image⋄i⋄i⟩                                 # image newWidth newHeight                                          # Resize image (Bicubic scaling algorithm)
imageResizeNN                    ⇐                         "ImageResizeNN"                    _R⟨"*"∾image⋄i⋄i⟩                                 # image newWidth newHeight                                          # Resize image (Nearest-Neighbor scaling algorithm)
imageResizeNNRef                 ⇐                         "ImageResizeNN"                    _R⟨"&"∾image⋄i⋄i⟩                                 # image newWidth newHeight                                          # Resize image (Nearest-Neighbor scaling algorithm)
imageResizeCanvas                ⇐                         "ImageResizeCanvas"                _R⟨"*"∾image⋄i⋄i⋄i⋄i⋄color⟩                       # image newWidth newHeight offsetX offsetY fill                     # Resize canvas and fill with color
imageResizeCanvasRef             ⇐                         "ImageResizeCanvas"                _R⟨"&"∾image⋄i⋄i⋄i⋄i⋄color⟩                       # image newWidth newHeight offsetX offsetY fill                     # Resize canvas and fill with color
imageMipmaps                     ⇐                         "ImageMipmaps"                     _R⟨"*"∾image⟩                                     # image                                                             # Compute all mipmap levels for a provided image
imageMipmapsRef                  ⇐                         "ImageMipmaps"                     _R⟨"&"∾image⟩                                     # image                                                             # Compute all mipmap levels for a provided image
imageDither                      ⇐                         "ImageDither"                      _R⟨"*"∾image⋄i⋄i⋄i⋄i⟩                             # image rBpp gBpp bBpp aBpp                                         # Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
imageDitherRef                   ⇐                         "ImageDither"                      _R⟨"&"∾image⋄i⋄i⋄i⋄i⟩                             # image rBpp gBpp bBpp aBpp                                         # Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
imageFlipVertical                ⇐                         "ImageFlipVertical"                _R⟨"*"∾image⟩                                     # image                                                             # Flip image vertically
imageFlipVerticalRef             ⇐                         "ImageFlipVertical"                _R⟨"&"∾image⟩                                     # image                                                             # Flip image vertically
imageFlipHorizontal              ⇐                         "ImageFlipHorizontal"              _R⟨"*"∾image⟩                                     # image                                                             # Flip image horizontally
imageFlipHorizontalRef           ⇐                         "ImageFlipHorizontal"              _R⟨"&"∾image⟩                                     # image                                                             # Flip image horizontally
imageRotate                      ⇐                         "ImageRotate"                      _R⟨"*"∾image⋄i⟩                                   # image degrees                                                     # Rotate image by input angle in degrees (-359 to 359)
imageRotateRef                   ⇐                         "ImageRotate"                      _R⟨"&"∾image⋄i⟩                                   # image degrees                                                     # Rotate image by input angle in degrees (-359 to 359)
imageRotateCW                    ⇐                         "ImageRotateCW"                    _R⟨"*"∾image⟩                                     # image                                                             # Rotate image clockwise 90deg
imageRotateCWRef                 ⇐                         "ImageRotateCW"                    _R⟨"&"∾image⟩                                     # image                                                             # Rotate image clockwise 90deg
imageRotateCCW                   ⇐                         "ImageRotateCCW"                   _R⟨"*"∾image⟩                                     # image                                                             # Rotate image counter-clockwise 90deg
imageRotateCCWRef                ⇐                         "ImageRotateCCW"                   _R⟨"&"∾image⟩                                     # image                                                             # Rotate image counter-clockwise 90deg
imageColorTint                   ⇐                         "ImageColorTint"                   _R⟨"*"∾image⋄color⟩                               # image color                                                       # Modify image color: tint
imageColorTintRef                ⇐                         "ImageColorTint"                   _R⟨"&"∾image⋄color⟩                               # image color                                                       # Modify image color: tint
imageColorInvert                 ⇐                         "ImageColorInvert"                 _R⟨"*"∾image⟩                                     # image                                                             # Modify image color: invert
imageColorInvertRef              ⇐                         "ImageColorInvert"                 _R⟨"&"∾image⟩                                     # image                                                             # Modify image color: invert
imageColorGrayscale              ⇐                         "ImageColorGrayscale"              _R⟨"*"∾image⟩                                     # image                                                             # Modify image color: grayscale
imageColorGrayscaleRef           ⇐                         "ImageColorGrayscale"              _R⟨"&"∾image⟩                                     # image                                                             # Modify image color: grayscale
imageColorContrast               ⇐                         "ImageColorContrast"               _R⟨"*"∾image⋄f⟩                                   # image contrast                                                    # Modify image color: contrast (-100 to 100)
imageColorContrastRef            ⇐                         "ImageColorContrast"               _R⟨"&"∾image⋄f⟩                                   # image contrast                                                    # Modify image color: contrast (-100 to 100)
imageColorBrightness             ⇐                         "ImageColorBrightness"             _R⟨"*"∾image⋄i⟩                                   # image brightness                                                  # Modify image color: brightness (-255 to 255)
imageColorBrightnessRef          ⇐                         "ImageColorBrightness"             _R⟨"&"∾image⋄i⟩                                   # image brightness                                                  # Modify image color: brightness (-255 to 255)
imageColorReplace                ⇐                         "ImageColorReplace"                _R⟨"*"∾image⋄color⋄color⟩                         # image color replace                                               # Modify image color: replace color
imageColorReplaceRef             ⇐                         "ImageColorReplace"                _R⟨"&"∾image⋄color⋄color⟩                         # image color replace                                               # Modify image color: replace color
loadImageColors                  ⇐ (ptr⊣"*"∾color)         "LoadImageColors"                  _R⟨image⟩                                         # image                                                             # Load color data from image as a Color array (RGBA - 32bit)
loadImagePalette                 ⇐ (ptr⊣"*"∾color)         "LoadImagePalette"                 _R⟨image⋄i⋄"*"∾i⟩                                 # image maxPaletteSize colorCount                                   # Load colors palette from image as a Color array (RGBA - 32bit)
loadImagePaletteRef              ⇐ (ptr⊣"*"∾color)         "LoadImagePalette"                 _R⟨image⋄i⋄"&"∾i⟩                                 # image maxPaletteSize colorCount                                   # Load colors palette from image as a Color array (RGBA - 32bit)
unloadImageColors                ⇐                         "UnloadImageColors"                _R⟨"*"∾color⟩                                     # colors                                                            # Unload color data loaded with LoadImageColors()
unloadImageColorsRef             ⇐                         "UnloadImageColors"                _R⟨"&"∾color⟩                                     # colors                                                            # Unload color data loaded with LoadImageColors()
unloadImagePalette               ⇐                         "UnloadImagePalette"               _R⟨"*"∾color⟩                                     # colors                                                            # Unload colors palette loaded with LoadImagePalette()
unloadImagePaletteRef            ⇐                         "UnloadImagePalette"               _R⟨"&"∾color⟩                                     # colors                                                            # Unload colors palette loaded with LoadImagePalette()
getImageAlphaBorder              ⇐ rectangle               "GetImageAlphaBorder"              _R⟨image⋄f⟩                                       # image threshold                                                   # Get image alpha border rectangle
getImageColor                    ⇐ color                   "GetImageColor"                    _R⟨image⋄i⋄i⟩                                     # image x y                                                         # Get image pixel color at (x, y) position
imageClearBackground             ⇐                         "ImageClearBackground"             _R⟨"*"∾image⋄color⟩                               # dst color                                                         # Clear image background with given color
imageClearBackgroundRef          ⇐                         "ImageClearBackground"             _R⟨"&"∾image⋄color⟩                               # dst color                                                         # Clear image background with given color
imageDrawPixel                   ⇐                         "ImageDrawPixel"                   _R⟨"*"∾image⋄i⋄i⋄color⟩                           # dst posX posY color                                               # Draw pixel within an image
imageDrawPixelRef                ⇐                         "ImageDrawPixel"                   _R⟨"&"∾image⋄i⋄i⋄color⟩                           # dst posX posY color                                               # Draw pixel within an image
imageDrawPixelV                  ⇐                         "ImageDrawPixelV"                  _R⟨"*"∾image⋄v2⋄color⟩                            # dst position color                                                # Draw pixel within an image (Vector version)
imageDrawPixelVRef               ⇐                         "ImageDrawPixelV"                  _R⟨"&"∾image⋄v2⋄color⟩                            # dst position color                                                # Draw pixel within an image (Vector version)
imageDrawLine                    ⇐                         "ImageDrawLine"                    _R⟨"*"∾image⋄i⋄i⋄i⋄i⋄color⟩                       # dst startPosX startPosY endPosX endPosY color                     # Draw line within an image
imageDrawLineRef                 ⇐                         "ImageDrawLine"                    _R⟨"&"∾image⋄i⋄i⋄i⋄i⋄color⟩                       # dst startPosX startPosY endPosX endPosY color                     # Draw line within an image
imageDrawLineV                   ⇐                         "ImageDrawLineV"                   _R⟨"*"∾image⋄v2⋄v2⋄color⟩                         # dst start end color                                               # Draw line within an image (Vector version)
imageDrawLineVRef                ⇐                         "ImageDrawLineV"                   _R⟨"&"∾image⋄v2⋄v2⋄color⟩                         # dst start end color                                               # Draw line within an image (Vector version)
imageDrawCircle                  ⇐                         "ImageDrawCircle"                  _R⟨"*"∾image⋄i⋄i⋄i⋄color⟩                         # dst centerX centerY radius color                                  # Draw a filled circle within an image
imageDrawCircleRef               ⇐                         "ImageDrawCircle"                  _R⟨"&"∾image⋄i⋄i⋄i⋄color⟩                         # dst centerX centerY radius color                                  # Draw a filled circle within an image
imageDrawCircleV                 ⇐                         "ImageDrawCircleV"                 _R⟨"*"∾image⋄v2⋄i⋄color⟩                          # dst center radius color                                           # Draw a filled circle within an image (Vector version)
imageDrawCircleVRef              ⇐                         "ImageDrawCircleV"                 _R⟨"&"∾image⋄v2⋄i⋄color⟩                          # dst center radius color                                           # Draw a filled circle within an image (Vector version)
imageDrawCircleLines             ⇐                         "ImageDrawCircleLines"             _R⟨"*"∾image⋄i⋄i⋄i⋄color⟩                         # dst centerX centerY radius color                                  # Draw circle outline within an image
imageDrawCircleLinesRef          ⇐                         "ImageDrawCircleLines"             _R⟨"&"∾image⋄i⋄i⋄i⋄color⟩                         # dst centerX centerY radius color                                  # Draw circle outline within an image
imageDrawCircleLinesV            ⇐                         "ImageDrawCircleLinesV"            _R⟨"*"∾image⋄v2⋄i⋄color⟩                          # dst center radius color                                           # Draw circle outline within an image (Vector version)
imageDrawCircleLinesVRef         ⇐                         "ImageDrawCircleLinesV"            _R⟨"&"∾image⋄v2⋄i⋄color⟩                          # dst center radius color                                           # Draw circle outline within an image (Vector version)
imageDrawRectangle               ⇐                         "ImageDrawRectangle"               _R⟨"*"∾image⋄i⋄i⋄i⋄i⋄color⟩                       # dst posX posY width height color                                  # Draw rectangle within an image
imageDrawRectangleRef            ⇐                         "ImageDrawRectangle"               _R⟨"&"∾image⋄i⋄i⋄i⋄i⋄color⟩                       # dst posX posY width height color                                  # Draw rectangle within an image
imageDrawRectangleV              ⇐                         "ImageDrawRectangleV"              _R⟨"*"∾image⋄v2⋄v2⋄color⟩                         # dst position size color                                           # Draw rectangle within an image (Vector version)
imageDrawRectangleVRef           ⇐                         "ImageDrawRectangleV"              _R⟨"&"∾image⋄v2⋄v2⋄color⟩                         # dst position size color                                           # Draw rectangle within an image (Vector version)
imageDrawRectangleRec            ⇐                         "ImageDrawRectangleRec"            _R⟨"*"∾image⋄rectangle⋄color⟩                     # dst rec color                                                     # Draw rectangle within an image
imageDrawRectangleRecRef         ⇐                         "ImageDrawRectangleRec"            _R⟨"&"∾image⋄rectangle⋄color⟩                     # dst rec color                                                     # Draw rectangle within an image
imageDrawRectangleLines          ⇐                         "ImageDrawRectangleLines"          _R⟨"*"∾image⋄rectangle⋄i⋄color⟩                   # dst rec thick color                                               # Draw rectangle lines within an image
imageDrawRectangleLinesRef       ⇐                         "ImageDrawRectangleLines"          _R⟨"&"∾image⋄rectangle⋄i⋄color⟩                   # dst rec thick color                                               # Draw rectangle lines within an image
imageDraw                        ⇐                         "ImageDraw"                        _R⟨"*"∾image⋄image⋄rectangle⋄rectangle⋄color⟩     # dst src srcRec dstRec tint                                        # Draw a source image within a destination image (tint applied to source)
imageDrawRef                     ⇐                         "ImageDraw"                        _R⟨"&"∾image⋄image⋄rectangle⋄rectangle⋄color⟩     # dst src srcRec dstRec tint                                        # Draw a source image within a destination image (tint applied to source)
imageDrawText                    ⇐                         "ImageDrawText"                    _R⟨"*"∾image⋄str⋄i⋄i⋄i⋄color⟩                     # dst text posX posY fontSize color                                 # Draw text (using default font) within an image (destination)
imageDrawTextRef                 ⇐                         "ImageDrawText"                    _R⟨"&"∾image⋄str⋄i⋄i⋄i⋄color⟩                     # dst text posX posY fontSize color                                 # Draw text (using default font) within an image (destination)
imageDrawTextEx                  ⇐                         "ImageDrawTextEx"                  _R⟨"*"∾image⋄font⋄str⋄v2⋄f⋄f⋄color⟩               # dst font text position fontSize spacing tint                      # Draw text (custom sprite font) within an image (destination)
imageDrawTextExRef               ⇐                         "ImageDrawTextEx"                  _R⟨"&"∾image⋄font⋄str⋄v2⋄f⋄f⋄color⟩               # dst font text position fontSize spacing tint                      # Draw text (custom sprite font) within an image (destination)
loadTexture                      ⇐ texture2D               "LoadTexture"                      _R⟨str⟩                                           # fileName                                                          # Load texture from file into GPU memory (VRAM)
loadTextureFromImage             ⇐ texture2D               "LoadTextureFromImage"             _R⟨image⟩                                         # image                                                             # Load texture from image data
loadTextureCubemap               ⇐ textureCubemap          "LoadTextureCubemap"               _R⟨image⋄i⟩                                       # image layout                                                      # Load cubemap from image, multiple image cubemap layouts supported
loadRenderTexture                ⇐ renderTexture2D         "LoadRenderTexture"                _R⟨i⋄i⟩                                           # width height                                                      # Load texture for rendering (framebuffer)
isTextureReady                   ⇐ bool                    "IsTextureReady"                   _R⟨texture2D⟩                                     # texture                                                           # Check if a texture is ready
unloadTexture                    ⇐                         "UnloadTexture"                    _R⟨texture2D⟩                                     # texture                                                           # Unload texture from GPU memory (VRAM)
isRenderTextureReady             ⇐ bool                    "IsRenderTextureReady"             _R⟨renderTexture2D⟩                               # target                                                            # Check if a render texture is ready
unloadRenderTexture              ⇐                         "UnloadRenderTexture"              _R⟨renderTexture2D⟩                               # target                                                            # Unload render texture from GPU memory (VRAM)
updateTexture                    ⇐                         "UpdateTexture"                    _R⟨texture2D⋄ptr⟩                                 # texture pixels                                                    # Update GPU texture with new data
updateTextureRaw                 ⇐                         "UpdateTexture"                    _R⟨texture2D⋄"*i8"⟩                               # texture pixels                                                    # Update GPU texture with new data
updateTextureRec                 ⇐                         "UpdateTextureRec"                 _R⟨texture2D⋄rectangle⋄ptr⟩                       # texture rec pixels                                                # Update GPU texture rectangle with new data
updateTextureRecRaw              ⇐                         "UpdateTextureRec"                 _R⟨texture2D⋄rectangle⋄"*i8"⟩                     # texture rec pixels                                                # Update GPU texture rectangle with new data
genTextureMipmaps                ⇐                         "GenTextureMipmaps"                _R⟨"*"∾texture2D⟩                                 # texture                                                           # Generate GPU mipmaps for a texture
genTextureMipmapsRef             ⇐                         "GenTextureMipmaps"                _R⟨"&"∾texture2D⟩                                 # texture                                                           # Generate GPU mipmaps for a texture
setTextureFilter                 ⇐                         "SetTextureFilter"                 _R⟨texture2D⋄i⟩                                   # texture filter                                                    # Set texture scaling filter mode
setTextureWrap                   ⇐                         "SetTextureWrap"                   _R⟨texture2D⋄i⟩                                   # texture wrap                                                      # Set texture wrapping mode
drawTexture                      ⇐                         "DrawTexture"                      _R⟨texture2D⋄i⋄i⋄color⟩                           # texture posX posY tint                                            # Draw a Texture2D
drawTextureV                     ⇐                         "DrawTextureV"                     _R⟨texture2D⋄v2⋄color⟩                            # texture position tint                                             # Draw a Texture2D with position defined as Vector2
drawTextureEx                    ⇐                         "DrawTextureEx"                    _R⟨texture2D⋄v2⋄f⋄f⋄color⟩                        # texture position rotation scale tint                              # Draw a Texture2D with extended parameters
drawTextureRec                   ⇐                         "DrawTextureRec"                   _R⟨texture2D⋄rectangle⋄v2⋄color⟩                  # texture source position tint                                      # Draw a part of a texture defined by a rectangle
drawTexturePro                   ⇐                         "DrawTexturePro"                   _R⟨texture2D⋄rectangle⋄rectangle⋄v2⋄f⋄color⟩      # texture source dest origin rotation tint                          # Draw a part of a texture defined by a rectangle with 'pro' parameters
drawTextureNPatch                ⇐                         "DrawTextureNPatch"                _R⟨texture2D⋄nPatchInfo⋄rectangle⋄v2⋄f⋄color⟩     # texture nPatchInfo dest origin rotation tint                      # Draws a texture (or part of it) that stretches or shrinks nicely
fade                             ⇐ color                   "Fade"                             _R⟨color⋄f⟩                                       # color alpha                                                       # Get color with alpha applied, alpha goes from 0.0f to 1.0f
colorToInt                       ⇐ i                       "ColorToInt"                       _R⟨color⟩                                         # color                                                             # Get hexadecimal value for a Color
colorNormalize                   ⇐ v4                      "ColorNormalize"                   _R⟨color⟩                                         # color                                                             # Get Color normalized as float [0..1]
colorFromNormalized              ⇐ color                   "ColorFromNormalized"              _R⟨v4⟩                                            # normalized                                                        # Get Color from normalized values [0..1]
colorToHSV                       ⇐ v3                      "ColorToHSV"                       _R⟨color⟩                                         # color                                                             # Get HSV values for a Color, hue [0..360], saturation/value [0..1]
colorFromHSV                     ⇐ color                   "ColorFromHSV"                     _R⟨f⋄f⋄f⟩                                         # hue saturation value                                              # Get a Color from HSV values, hue [0..360], saturation/value [0..1]
colorTint                        ⇐ color                   "ColorTint"                        _R⟨color⋄color⟩                                   # color tint                                                        # Get color multiplied with another color
colorBrightness                  ⇐ color                   "ColorBrightness"                  _R⟨color⋄f⟩                                       # color factor                                                      # Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
colorContrast                    ⇐ color                   "ColorContrast"                    _R⟨color⋄f⟩                                       # color contrast                                                    # Get color with contrast correction, contrast values between -1.0f and 1.0f
colorAlpha                       ⇐ color                   "ColorAlpha"                       _R⟨color⋄f⟩                                       # color alpha                                                       # Get color with alpha applied, alpha goes from 0.0f to 1.0f
colorAlphaBlend                  ⇐ color                   "ColorAlphaBlend"                  _R⟨color⋄color⋄color⟩                             # dst src tint                                                      # Get src alpha-blended into dst color with tint
getColor                         ⇐ color                   "GetColor"                         _R⟨u⟩                                             # hexValue                                                          # Get Color structure from hexadecimal value
getPixelColor                    ⇐ color                   "GetPixelColor"                    _R⟨ptr⋄i⟩                                         # srcPtr format                                                     # Get Color from a source pixel pointer of certain format
getPixelColorRef                 ⇐ color                   "GetPixelColor"                    _R⟨"&u8"⋄i⟩                                       # srcPtr format                                                     # Get Color from a source pixel pointer of certain format
setPixelColor                    ⇐                         "SetPixelColor"                    _R⟨ptr⋄color⋄i⟩                                   # dstPtr color format                                               # Set color formatted into destination pixel pointer
setPixelColorRef                 ⇐                         "SetPixelColor"                    _R⟨"&u8"⋄color⋄i⟩                                 # dstPtr color format                                               # Set color formatted into destination pixel pointer
getPixelDataSize                 ⇐ i                       "GetPixelDataSize"                 _R⟨i⋄i⋄i⟩                                         # width height format                                               # Get pixel data size in bytes for certain format
getFontDefault                   ⇐ font                    "GetFontDefault"                   _R⟨⟩                                              #                                                                   # Get the default Font
loadFont                         ⇐ font                    "LoadFont"                         _R⟨str⟩                                           # fileName                                                          # Load font from file into GPU memory (VRAM)
loadFontEx                       ⇐ font                    "LoadFontEx"                       _R⟨str⋄i⋄"*"∾i⋄i⟩                                 # fileName fontSize codepoints codepointCount                       # Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set
loadFontExRef                    ⇐ font                    "LoadFontEx"                       _R⟨str⋄i⋄"&"∾i⋄i⟩                                 # fileName fontSize codepoints codepointCount                       # Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set
loadFontFromImage                ⇐ font                    "LoadFontFromImage"                _R⟨image⋄color⋄i⟩                                 # image key firstChar                                               # Load font from Image (XNA style)
loadFontFromMemory               ⇐ font                    "LoadFontFromMemory"               _R⟨str⋄ustr⋄i⋄i⋄"*"∾i⋄i⟩                          # fileType fileData dataSize fontSize codepoints codepointCount     # Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
loadFontFromMemoryRef            ⇐ font                    "LoadFontFromMemory"               _R⟨str⋄ustr⋄i⋄i⋄"&"∾i⋄i⟩                          # fileType fileData dataSize fontSize codepoints codepointCount     # Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
isFontReady                      ⇐ bool                    "IsFontReady"                      _R⟨font⟩                                          # font                                                              # Check if a font is ready
loadFontData                     ⇐ (ptr⊣"*"∾glyphInfo)     "LoadFontData"                     _R⟨ustr⋄i⋄i⋄"*"∾i⋄i⋄i⟩                            # fileData dataSize fontSize codepoints codepointCount type         # Load font data for further use
loadFontDataRef                  ⇐ (ptr⊣"*"∾glyphInfo)     "LoadFontData"                     _R⟨ustr⋄i⋄i⋄"&"∾i⋄i⋄i⟩                            # fileData dataSize fontSize codepoints codepointCount type         # Load font data for further use
genImageFontAtlas                ⇐ image                   "GenImageFontAtlas"                _R⟨"*"∾glyphInfo⋄"**"∾rectangle⋄i⋄i⋄i⋄i⟩          # glyphs glyphRecs glyphCount fontSize padding packMethod           # Generate image font atlas using chars info
genImageFontAtlasRef             ⇐ image                   "GenImageFontAtlas"                _R⟨"*"∾glyphInfo⋄"&*"∾rectangle⋄i⋄i⋄i⋄i⟩          # glyphs glyphRecs glyphCount fontSize padding packMethod           # Generate image font atlas using chars info
unloadFontData                   ⇐                         "UnloadFontData"                   _R⟨"*"∾glyphInfo⋄i⟩                               # glyphs glyphCount                                                 # Unload font chars info data (RAM)
unloadFontDataRef                ⇐                         "UnloadFontData"                   _R⟨"&"∾glyphInfo⋄i⟩                               # glyphs glyphCount                                                 # Unload font chars info data (RAM)
unloadFont                       ⇐                         "UnloadFont"                       _R⟨font⟩                                          # font                                                              # Unload font from GPU memory (VRAM)
exportFontAsCode                 ⇐ bool                    "ExportFontAsCode"                 _R⟨font⋄str⟩                                      # font fileName                                                     # Export font as code file, returns true on success
drawFPS                          ⇐                         "DrawFPS"                          _R⟨i⋄i⟩                                           # posX posY                                                         # Draw current FPS
drawText                         ⇐                         "DrawText"                         _R⟨str⋄i⋄i⋄i⋄color⟩                               # text posX posY fontSize color                                     # Draw text (using default font)
drawTextEx                       ⇐                         "DrawTextEx"                       _R⟨font⋄str⋄v2⋄f⋄f⋄color⟩                         # font text position fontSize spacing tint                          # Draw text using font and additional parameters
drawTextPro                      ⇐                         "DrawTextPro"                      _R⟨font⋄str⋄v2⋄v2⋄f⋄f⋄f⋄color⟩                    # font text position origin rotation fontSize spacing tint          # Draw text using Font and pro parameters (rotation)
drawTextCodepoint                ⇐                         "DrawTextCodepoint"                _R⟨font⋄i⋄v2⋄f⋄color⟩                             # font codepoint position fontSize tint                             # Draw one character (codepoint)
drawTextCodepoints               ⇐                         "DrawTextCodepoints"               _R⟨font⋄"*"∾i⋄i⋄v2⋄f⋄f⋄color⟩                     # font codepoints codepointCount position fontSize spacing tint     # Draw multiple character (codepoint)
setTextLineSpacing               ⇐                         "SetTextLineSpacing"               _R⟨i⟩                                             # spacing                                                           # Set vertical line spacing when drawing with line-breaks
measureText                      ⇐ i                       "MeasureText"                      _R⟨str⋄i⟩                                         # text fontSize                                                     # Measure string width for default font
measureTextEx                    ⇐ v2                      "MeasureTextEx"                    _R⟨font⋄str⋄f⋄f⟩                                  # font text fontSize spacing                                        # Measure string size for Font
getGlyphIndex                    ⇐ i                       "GetGlyphIndex"                    _R⟨font⋄i⟩                                        # font codepoint                                                    # Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
getGlyphInfo                     ⇐ glyphInfo               "GetGlyphInfo"                     _R⟨font⋄i⟩                                        # font codepoint                                                    # Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
getGlyphAtlasRec                 ⇐ rectangle               "GetGlyphAtlasRec"                 _R⟨font⋄i⟩                                        # font codepoint                                                    # Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
loadUTF8                         ⇐ (ptr⊣str)               "LoadUTF8"                         _R⟨"*"∾i⋄i⟩                                       # codepoints length                                                 # Load UTF-8 text encoded from codepoints array
unloadUTF8                       ⇐                         "UnloadUTF8"                       _R⟨str⟩                                           # text                                                              # Unload UTF-8 text encoded from codepoints array
unloadUTF8Ref                    ⇐                         "UnloadUTF8"                       _R⟨"&u8:c8"⟩                                      # text                                                              # Unload UTF-8 text encoded from codepoints array
loadCodepoints                   ⇐ (ptr⊣"*"∾i)             "LoadCodepoints"                   _R⟨str⋄"*"∾i⟩                                     # text count                                                        # Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
loadCodepointsRef                ⇐ (ptr⊣"*"∾i)             "LoadCodepoints"                   _R⟨str⋄"&"∾i⟩                                     # text count                                                        # Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
unloadCodepoints                 ⇐                         "UnloadCodepoints"                 _R⟨"*"∾i⟩                                         # codepoints                                                        # Unload codepoints data from memory
unloadCodepointsRef              ⇐                         "UnloadCodepoints"                 _R⟨"&"∾i⟩                                         # codepoints                                                        # Unload codepoints data from memory
getCodepointCount                ⇐ i                       "GetCodepointCount"                _R⟨str⟩                                           # text                                                              # Get total number of codepoints in a UTF-8 encoded string
getCodepoint                     ⇐ i                       "GetCodepoint"                     _R⟨str⋄"*"∾i⟩                                     # text codepointSize                                                # Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
getCodepointRef                  ⇐ i                       "GetCodepoint"                     _R⟨str⋄"&"∾i⟩                                     # text codepointSize                                                # Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
getCodepointNext                 ⇐ i                       "GetCodepointNext"                 _R⟨str⋄"*"∾i⟩                                     # text codepointSize                                                # Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
getCodepointNextRef              ⇐ i                       "GetCodepointNext"                 _R⟨str⋄"&"∾i⟩                                     # text codepointSize                                                # Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
getCodepointPrevious             ⇐ i                       "GetCodepointPrevious"             _R⟨str⋄"*"∾i⟩                                     # text codepointSize                                                # Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
getCodepointPreviousRef          ⇐ i                       "GetCodepointPrevious"             _R⟨str⋄"&"∾i⟩                                     # text codepointSize                                                # Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
codepointToUTF8                  ⇐ (ptr⊣str)               "CodepointToUTF8"                  _R⟨i⋄"*"∾i⟩                                       # codepoint utf8Size                                                # Encode one codepoint into UTF-8 byte array (array length returned as parameter)
codepointToUTF8Ref               ⇐ (ptr⊣str)               "CodepointToUTF8"                  _R⟨i⋄"&"∾i⟩                                       # codepoint utf8Size                                                # Encode one codepoint into UTF-8 byte array (array length returned as parameter)
textCopy                         ⇐ i                       "TextCopy"                         _R⟨str⋄str⟩                                       # dst src                                                           # Copy one string to another, returns bytes copied
textCopyRef                      ⇐ i                       "TextCopy"                         _R⟨"&u8:c8"⋄str⟩                                  # dst src                                                           # Copy one string to another, returns bytes copied
textIsEqual                      ⇐ bool                    "TextIsEqual"                      _R⟨str⋄str⟩                                       # text1 text2                                                       # Check if two text string are equal
textLength                       ⇐ u                       "TextLength"                       _R⟨str⟩                                           # text                                                              # Get text length, checks for '\0' ending
textFormat                       ⇐ (ptr⊣str)               "TextFormat"                       _R⟨str⋄ptr⟩                                       # text args                                                         # Text formatting with variables (sprintf() style)
textSubtext                      ⇐ (ptr⊣str)               "TextSubtext"                      _R⟨str⋄i⋄i⟩                                       # text position length                                              # Get a piece of a text string
textReplace                      ⇐ (ptr⊣str)               "TextReplace"                      _R⟨str⋄str⋄str⟩                                   # text replace by                                                   # Replace text string (WARNING: memory must be freed!)
textReplaceRef                   ⇐ (ptr⊣str)               "TextReplace"                      _R⟨"&u8:c8"⋄str⋄str⟩                              # text replace by                                                   # Replace text string (WARNING: memory must be freed!)
textInsert                       ⇐ (ptr⊣str)               "TextInsert"                       _R⟨str⋄str⋄i⟩                                     # text insert position                                              # Insert text in a position (WARNING: memory must be freed!)
textJoin                         ⇐ (ptr⊣str)               "TextJoin"                         _R⟨"*"∾str⋄i⋄str⟩                                 # textList count delimiter                                          # Join text strings with delimiter
textSplit                        ⇐ (ptr⊣"*"∾str)           "TextSplit"                        _R⟨str⋄u8⋄"*"∾i⟩                                  # text delimiter count                                              # Split text into multiple strings
textSplitRef                     ⇐ (ptr⊣"*"∾str)           "TextSplit"                        _R⟨str⋄u8⋄"&"∾i⟩                                  # text delimiter count                                              # Split text into multiple strings
textAppend                       ⇐                         "TextAppend"                       _R⟨str⋄str⋄"*"∾i⟩                                 # text append position                                              # Append text at specific position and move cursor!
textAppendRef                    ⇐                         "TextAppend"                       _R⟨"&u8:c8"⋄str⋄"&"∾i⟩                            # text append position                                              # Append text at specific position and move cursor!
textFindIndex                    ⇐ i                       "TextFindIndex"                    _R⟨str⋄str⟩                                       # text find                                                         # Find first text occurrence within a string
textToUpper                      ⇐ (ptr⊣str)               "TextToUpper"                      _R⟨str⟩                                           # text                                                              # Get upper case version of provided string
textToLower                      ⇐ (ptr⊣str)               "TextToLower"                      _R⟨str⟩                                           # text                                                              # Get lower case version of provided string
textToPascal                     ⇐ (ptr⊣str)               "TextToPascal"                     _R⟨str⟩                                           # text                                                              # Get Pascal case notation version of provided string
textToInteger                    ⇐ i                       "TextToInteger"                    _R⟨str⟩                                           # text                                                              # Get integer value from text (negative values not supported)
drawLine3D                       ⇐                         "DrawLine3D"                       _R⟨v3⋄v3⋄color⟩                                   # startPos endPos color                                             # Draw a line in 3D world space
drawPoint3D                      ⇐                         "DrawPoint3D"                      _R⟨v3⋄color⟩                                      # position color                                                    # Draw a point in 3D space, actually a small line
drawCircle3D                     ⇐                         "DrawCircle3D"                     _R⟨v3⋄f⋄v3⋄f⋄color⟩                               # center radius rotationAxis rotationAngle color                    # Draw a circle in 3D world space
drawTriangle3D                   ⇐                         "DrawTriangle3D"                   _R⟨v3⋄v3⋄v3⋄color⟩                                # v1 v2 v3 color                                                    # Draw a color-filled triangle (vertex in counter-clockwise order!)
drawTriangleStrip3D              ⇐                         "DrawTriangleStrip3D"              _R⟨"*"∾v3⋄i⋄color⟩                                # points pointCount color                                           # Draw a triangle strip defined by points
drawTriangleStrip3DRef           ⇐                         "DrawTriangleStrip3D"              _R⟨"&"∾v3⋄i⋄color⟩                                # points pointCount color                                           # Draw a triangle strip defined by points
drawCube                         ⇐                         "DrawCube"                         _R⟨v3⋄f⋄f⋄f⋄color⟩                                # position width height length color                                # Draw cube
drawCubeV                        ⇐                         "DrawCubeV"                        _R⟨v3⋄v3⋄color⟩                                   # position size color                                               # Draw cube (Vector version)
drawCubeWires                    ⇐                         "DrawCubeWires"                    _R⟨v3⋄f⋄f⋄f⋄color⟩                                # position width height length color                                # Draw cube wires
drawCubeWiresV                   ⇐                         "DrawCubeWiresV"                   _R⟨v3⋄v3⋄color⟩                                   # position size color                                               # Draw cube wires (Vector version)
drawSphere                       ⇐                         "DrawSphere"                       _R⟨v3⋄f⋄color⟩                                    # centerPos radius color                                            # Draw sphere
drawSphereEx                     ⇐                         "DrawSphereEx"                     _R⟨v3⋄f⋄i⋄i⋄color⟩                                # centerPos radius rings slices color                               # Draw sphere with extended parameters
drawSphereWires                  ⇐                         "DrawSphereWires"                  _R⟨v3⋄f⋄i⋄i⋄color⟩                                # centerPos radius rings slices color                               # Draw sphere wires
drawCylinder                     ⇐                         "DrawCylinder"                     _R⟨v3⋄f⋄f⋄f⋄i⋄color⟩                              # position radiusTop radiusBottom height slices color               # Draw a cylinder/cone
drawCylinderEx                   ⇐                         "DrawCylinderEx"                   _R⟨v3⋄v3⋄f⋄f⋄i⋄color⟩                             # startPos endPos startRadius endRadius sides color                 # Draw a cylinder with base at startPos and top at endPos
drawCylinderWires                ⇐                         "DrawCylinderWires"                _R⟨v3⋄f⋄f⋄f⋄i⋄color⟩                              # position radiusTop radiusBottom height slices color               # Draw a cylinder/cone wires
drawCylinderWiresEx              ⇐                         "DrawCylinderWiresEx"              _R⟨v3⋄v3⋄f⋄f⋄i⋄color⟩                             # startPos endPos startRadius endRadius sides color                 # Draw a cylinder wires with base at startPos and top at endPos
drawCapsule                      ⇐                         "DrawCapsule"                      _R⟨v3⋄v3⋄f⋄i⋄i⋄color⟩                             # startPos endPos radius slices rings color                         # Draw a capsule with the center of its sphere caps at startPos and endPos
drawCapsuleWires                 ⇐                         "DrawCapsuleWires"                 _R⟨v3⋄v3⋄f⋄i⋄i⋄color⟩                             # startPos endPos radius slices rings color                         # Draw capsule wireframe with the center of its sphere caps at startPos and endPos
drawPlane                        ⇐                         "DrawPlane"                        _R⟨v3⋄v2⋄color⟩                                   # centerPos size color                                              # Draw a plane XZ
drawRay                          ⇐                         "DrawRay"                          _R⟨ray⋄color⟩                                     # ray color                                                         # Draw a ray line
drawGrid                         ⇐                         "DrawGrid"                         _R⟨i⋄f⟩                                           # slices spacing                                                    # Draw a grid (centered at (0, 0, 0))
loadModel                        ⇐ model                   "LoadModel"                        _R⟨str⟩                                           # fileName                                                          # Load model from files (meshes and materials)
loadModelFromMesh                ⇐ model                   "LoadModelFromMesh"                _R⟨mesh⟩                                          # mesh                                                              # Load model from generated mesh (default material)
isModelReady                     ⇐ bool                    "IsModelReady"                     _R⟨model⟩                                         # model                                                             # Check if a model is ready
unloadModel                      ⇐                         "UnloadModel"                      _R⟨model⟩                                         # model                                                             # Unload model (including meshes) from memory (RAM and/or VRAM)
getModelBoundingBox              ⇐ boundingBox             "GetModelBoundingBox"              _R⟨model⟩                                         # model                                                             # Compute model bounding box limits (considers all meshes)
drawModel                        ⇐                         "DrawModel"                        _R⟨model⋄v3⋄f⋄color⟩                              # model position scale tint                                         # Draw a model (with texture if set)
drawModelEx                      ⇐                         "DrawModelEx"                      _R⟨model⋄v3⋄v3⋄f⋄v3⋄color⟩                        # model position rotationAxis rotationAngle scale tint              # Draw a model with extended parameters
drawModelWires                   ⇐                         "DrawModelWires"                   _R⟨model⋄v3⋄f⋄color⟩                              # model position scale tint                                         # Draw a model wires (with texture if set)
drawModelWiresEx                 ⇐                         "DrawModelWiresEx"                 _R⟨model⋄v3⋄v3⋄f⋄v3⋄color⟩                        # model position rotationAxis rotationAngle scale tint              # Draw a model wires (with texture if set) with extended parameters
drawBoundingBox                  ⇐                         "DrawBoundingBox"                  _R⟨boundingBox⋄color⟩                             # box color                                                         # Draw bounding box (wires)
drawBillboard                    ⇐                         "DrawBillboard"                    _R⟨camera⋄texture2D⋄v3⋄f⋄color⟩                   # camera texture position size tint                                 # Draw a billboard texture
drawBillboardRec                 ⇐                         "DrawBillboardRec"                 _R⟨camera⋄texture2D⋄rectangle⋄v3⋄v2⋄color⟩        # camera texture source position size tint                          # Draw a billboard texture defined by source
drawBillboardPro                 ⇐                         "DrawBillboardPro"                 _R⟨camera⋄texture2D⋄rectangle⋄v3⋄v3⋄v2⋄v2⋄f⋄color⟩# camera texture source position up size origin rotation tint       # Draw a billboard texture defined by source and rotation
uploadMesh                       ⇐                         "UploadMesh"                       _R⟨"*"∾mesh⋄bool⟩                                 # mesh dynamic                                                      # Upload mesh vertex data in GPU and provide VAO/VBO ids
uploadMeshRef                    ⇐                         "UploadMesh"                       _R⟨"&"∾mesh⋄bool⟩                                 # mesh dynamic                                                      # Upload mesh vertex data in GPU and provide VAO/VBO ids
updateMeshBuffer                 ⇐                         "UpdateMeshBuffer"                 _R⟨mesh⋄i⋄ptr⋄i⋄i⟩                                # mesh index data dataSize offset                                   # Update mesh vertex data in GPU for a specific buffer index
updateMeshBufferRaw              ⇐                         "UpdateMeshBuffer"                 _R⟨mesh⋄i⋄"*i8"⋄i⋄i⟩                              # mesh index data dataSize offset                                   # Update mesh vertex data in GPU for a specific buffer index
unloadMesh                       ⇐                         "UnloadMesh"                       _R⟨mesh⟩                                          # mesh                                                              # Unload mesh data from CPU and GPU
drawMesh                         ⇐                         "DrawMesh"                         _R⟨mesh⋄material⋄matrix⟩                          # mesh material transform                                           # Draw a 3d mesh with material and transform
drawMeshInstanced                ⇐                         "DrawMeshInstanced"                _R⟨mesh⋄material⋄"*"∾matrix⋄i⟩                    # mesh material transforms instances                                # Draw multiple mesh instances with material and different transforms
exportMesh                       ⇐ bool                    "ExportMesh"                       _R⟨mesh⋄str⟩                                      # mesh fileName                                                     # Export mesh data to file, returns true on success
getMeshBoundingBox               ⇐ boundingBox             "GetMeshBoundingBox"               _R⟨mesh⟩                                          # mesh                                                              # Compute mesh bounding box limits
genMeshTangents                  ⇐                         "GenMeshTangents"                  _R⟨"*"∾mesh⟩                                      # mesh                                                              # Compute mesh tangents
genMeshTangentsRef               ⇐                         "GenMeshTangents"                  _R⟨"&"∾mesh⟩                                      # mesh                                                              # Compute mesh tangents
genMeshPoly                      ⇐ mesh                    "GenMeshPoly"                      _R⟨i⋄f⟩                                           # sides radius                                                      # Generate polygonal mesh
genMeshPlane                     ⇐ mesh                    "GenMeshPlane"                     _R⟨f⋄f⋄i⋄i⟩                                       # width length resX resZ                                            # Generate plane mesh (with subdivisions)
genMeshCube                      ⇐ mesh                    "GenMeshCube"                      _R⟨f⋄f⋄f⟩                                         # width height length                                               # Generate cuboid mesh
genMeshSphere                    ⇐ mesh                    "GenMeshSphere"                    _R⟨f⋄i⋄i⟩                                         # radius rings slices                                               # Generate sphere mesh (standard sphere)
genMeshHemiSphere                ⇐ mesh                    "GenMeshHemiSphere"                _R⟨f⋄i⋄i⟩                                         # radius rings slices                                               # Generate half-sphere mesh (no bottom cap)
genMeshCylinder                  ⇐ mesh                    "GenMeshCylinder"                  _R⟨f⋄f⋄i⟩                                         # radius height slices                                              # Generate cylinder mesh
genMeshCone                      ⇐ mesh                    "GenMeshCone"                      _R⟨f⋄f⋄i⟩                                         # radius height slices                                              # Generate cone/pyramid mesh
genMeshTorus                     ⇐ mesh                    "GenMeshTorus"                     _R⟨f⋄f⋄i⋄i⟩                                       # radius size radSeg sides                                          # Generate torus mesh
genMeshKnot                      ⇐ mesh                    "GenMeshKnot"                      _R⟨f⋄f⋄i⋄i⟩                                       # radius size radSeg sides                                          # Generate trefoil knot mesh
genMeshHeightmap                 ⇐ mesh                    "GenMeshHeightmap"                 _R⟨image⋄v3⟩                                      # heightmap size                                                    # Generate heightmap mesh from image data
genMeshCubicmap                  ⇐ mesh                    "GenMeshCubicmap"                  _R⟨image⋄v3⟩                                      # cubicmap cubeSize                                                 # Generate cubes-based map mesh from image data
loadMaterials                    ⇐ (ptr⊣"*"∾material)      "LoadMaterials"                    _R⟨str⋄"*"∾i⟩                                     # fileName materialCount                                            # Load materials from model file
loadMaterialsRef                 ⇐ (ptr⊣"*"∾material)      "LoadMaterials"                    _R⟨str⋄"&"∾i⟩                                     # fileName materialCount                                            # Load materials from model file
loadMaterialDefault              ⇐ material                "LoadMaterialDefault"              _R⟨⟩                                              #                                                                   # Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
isMaterialReady                  ⇐ bool                    "IsMaterialReady"                  _R⟨material⟩                                      # material                                                          # Check if a material is ready
unloadMaterial                   ⇐                         "UnloadMaterial"                   _R⟨material⟩                                      # material                                                          # Unload material from GPU memory (VRAM)
setMaterialTexture               ⇐                         "SetMaterialTexture"               _R⟨"*"∾material⋄i⋄texture2D⟩                      # material mapType texture                                          # Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
setMaterialTextureRef            ⇐                         "SetMaterialTexture"               _R⟨"&"∾material⋄i⋄texture2D⟩                      # material mapType texture                                          # Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
setModelMeshMaterial             ⇐                         "SetModelMeshMaterial"             _R⟨"*"∾model⋄i⋄i⟩                                 # model meshId materialId                                           # Set material for a mesh
setModelMeshMaterialRef          ⇐                         "SetModelMeshMaterial"             _R⟨"&"∾model⋄i⋄i⟩                                 # model meshId materialId                                           # Set material for a mesh
loadModelAnimations              ⇐ (ptr⊣"*"∾modelAnimation)"LoadModelAnimations"              _R⟨str⋄"*"∾i⟩                                     # fileName animCount                                                # Load model animations from file
loadModelAnimationsRef           ⇐ (ptr⊣"*"∾modelAnimation)"LoadModelAnimations"              _R⟨str⋄"&"∾i⟩                                     # fileName animCount                                                # Load model animations from file
updateModelAnimation             ⇐                         "UpdateModelAnimation"             _R⟨model⋄modelAnimation⋄i⟩                        # model anim frame                                                  # Update model animation pose
unloadModelAnimation             ⇐                         "UnloadModelAnimation"             _R⟨modelAnimation⟩                                # anim                                                              # Unload animation data
unloadModelAnimations            ⇐                         "UnloadModelAnimations"            _R⟨"*"∾modelAnimation⋄i⟩                          # animations animCount                                              # Unload animation array data
unloadModelAnimationsRef         ⇐                         "UnloadModelAnimations"            _R⟨"&"∾modelAnimation⋄i⟩                          # animations animCount                                              # Unload animation array data
isModelAnimationValid            ⇐ bool                    "IsModelAnimationValid"            _R⟨model⋄modelAnimation⟩                          # model anim                                                        # Check model animation skeleton match
checkCollisionSpheres            ⇐ bool                    "CheckCollisionSpheres"            _R⟨v3⋄f⋄v3⋄f⟩                                     # center1 radius1 center2 radius2                                   # Check collision between two spheres
checkCollisionBoxes              ⇐ bool                    "CheckCollisionBoxes"              _R⟨boundingBox⋄boundingBox⟩                       # box1 box2                                                         # Check collision between two bounding boxes
checkCollisionBoxSphere          ⇐ bool                    "CheckCollisionBoxSphere"          _R⟨boundingBox⋄v3⋄f⟩                              # box center radius                                                 # Check collision between box and sphere
getRayCollisionSphere            ⇐ rayCollision            "GetRayCollisionSphere"            _R⟨ray⋄v3⋄f⟩                                      # ray center radius                                                 # Get collision info between ray and sphere
getRayCollisionBox               ⇐ rayCollision            "GetRayCollisionBox"               _R⟨ray⋄boundingBox⟩                               # ray box                                                           # Get collision info between ray and box
getRayCollisionMesh              ⇐ rayCollision            "GetRayCollisionMesh"              _R⟨ray⋄mesh⋄matrix⟩                               # ray mesh transform                                                # Get collision info between ray and mesh
getRayCollisionTriangle          ⇐ rayCollision            "GetRayCollisionTriangle"          _R⟨ray⋄v3⋄v3⋄v3⟩                                  # ray p1 p2 p3                                                      # Get collision info between ray and triangle
getRayCollisionQuad              ⇐ rayCollision            "GetRayCollisionQuad"              _R⟨ray⋄v3⋄v3⋄v3⋄v3⟩                               # ray p1 p2 p3 p4                                                   # Get collision info between ray and quad
initAudioDevice                  ⇐                         "InitAudioDevice"                  _R⟨⟩                                              #                                                                   # Initialize audio device and context
closeAudioDevice                 ⇐                         "CloseAudioDevice"                 _R⟨⟩                                              #                                                                   # Close the audio device and context
isAudioDeviceReady               ⇐ bool                    "IsAudioDeviceReady"               _R⟨⟩                                              #                                                                   # Check if audio device has been initialized successfully
setMasterVolume                  ⇐                         "SetMasterVolume"                  _R⟨f⟩                                             # volume                                                            # Set master volume (listener)
getMasterVolume                  ⇐ f                       "GetMasterVolume"                  _R⟨⟩                                              #                                                                   # Get master volume (listener)
loadWave                         ⇐ wave                    "LoadWave"                         _R⟨str⟩                                           # fileName                                                          # Load wave data from file
loadWaveFromMemory               ⇐ wave                    "LoadWaveFromMemory"               _R⟨str⋄ustr⋄i⟩                                    # fileType fileData dataSize                                        # Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
isWaveReady                      ⇐ bool                    "IsWaveReady"                      _R⟨wave⟩                                          # wave                                                              # Checks if wave data is ready
loadSound                        ⇐ sound                   "LoadSound"                        _R⟨str⟩                                           # fileName                                                          # Load sound from file
loadSoundFromWave                ⇐ sound                   "LoadSoundFromWave"                _R⟨wave⟩                                          # wave                                                              # Load sound from wave data
loadSoundAlias                   ⇐ sound                   "LoadSoundAlias"                   _R⟨sound⟩                                         # source                                                            # Create a new sound that shares the same sample data as the source sound, does not own the sound data
isSoundReady                     ⇐ bool                    "IsSoundReady"                     _R⟨sound⟩                                         # sound                                                             # Checks if a sound is ready
updateSound                      ⇐                         "UpdateSound"                      _R⟨sound⋄ptr⋄i⟩                                   # sound data sampleCount                                            # Update sound buffer with new data
updateSoundRaw                   ⇐                         "UpdateSound"                      _R⟨sound⋄"*i8"⋄i⟩                                 # sound data sampleCount                                            # Update sound buffer with new data
unloadWave                       ⇐                         "UnloadWave"                       _R⟨wave⟩                                          # wave                                                              # Unload wave data
unloadSound                      ⇐                         "UnloadSound"                      _R⟨sound⟩                                         # sound                                                             # Unload sound
unloadSoundAlias                 ⇐                         "UnloadSoundAlias"                 _R⟨sound⟩                                         # alias                                                             # Unload a sound alias (does not deallocate sample data)
exportWave                       ⇐ bool                    "ExportWave"                       _R⟨wave⋄str⟩                                      # wave fileName                                                     # Export wave data to file, returns true on success
exportWaveAsCode                 ⇐ bool                    "ExportWaveAsCode"                 _R⟨wave⋄str⟩                                      # wave fileName                                                     # Export wave sample data to code (.h), returns true on success
playSound                        ⇐                         "PlaySound"                        _R⟨sound⟩                                         # sound                                                             # Play a sound
stopSound                        ⇐                         "StopSound"                        _R⟨sound⟩                                         # sound                                                             # Stop playing a sound
pauseSound                       ⇐                         "PauseSound"                       _R⟨sound⟩                                         # sound                                                             # Pause a sound
resumeSound                      ⇐                         "ResumeSound"                      _R⟨sound⟩                                         # sound                                                             # Resume a paused sound
isSoundPlaying                   ⇐ bool                    "IsSoundPlaying"                   _R⟨sound⟩                                         # sound                                                             # Check if a sound is currently playing
setSoundVolume                   ⇐                         "SetSoundVolume"                   _R⟨sound⋄f⟩                                       # sound volume                                                      # Set volume for a sound (1.0 is max level)
setSoundPitch                    ⇐                         "SetSoundPitch"                    _R⟨sound⋄f⟩                                       # sound pitch                                                       # Set pitch for a sound (1.0 is base level)
setSoundPan                      ⇐                         "SetSoundPan"                      _R⟨sound⋄f⟩                                       # sound pan                                                         # Set pan for a sound (0.5 is center)
waveCopy                         ⇐ wave                    "WaveCopy"                         _R⟨wave⟩                                          # wave                                                              # Copy a wave to a new wave
waveCrop                         ⇐                         "WaveCrop"                         _R⟨"*"∾wave⋄i⋄i⟩                                  # wave initSample finalSample                                       # Crop a wave to defined samples range
waveCropRef                      ⇐                         "WaveCrop"                         _R⟨"&"∾wave⋄i⋄i⟩                                  # wave initSample finalSample                                       # Crop a wave to defined samples range
waveFormat                       ⇐                         "WaveFormat"                       _R⟨"*"∾wave⋄i⋄i⋄i⟩                                # wave sampleRate sampleSize channels                               # Convert wave data to desired format
waveFormatRef                    ⇐                         "WaveFormat"                       _R⟨"&"∾wave⋄i⋄i⋄i⟩                                # wave sampleRate sampleSize channels                               # Convert wave data to desired format
loadWaveSamples                  ⇐ (ptr⊣"*"∾f)             "LoadWaveSamples"                  _R⟨wave⟩                                          # wave                                                              # Load samples data from wave as a 32bit float data array
unloadWaveSamples                ⇐                         "UnloadWaveSamples"                _R⟨"*"∾f⟩                                         # samples                                                           # Unload samples data loaded with LoadWaveSamples()
unloadWaveSamplesRef             ⇐                         "UnloadWaveSamples"                _R⟨"&"∾f⟩                                         # samples                                                           # Unload samples data loaded with LoadWaveSamples()
loadMusicStream                  ⇐ music                   "LoadMusicStream"                  _R⟨str⟩                                           # fileName                                                          # Load music stream from file
loadMusicStreamFromMemory        ⇐ music                   "LoadMusicStreamFromMemory"        _R⟨str⋄ustr⋄i⟩                                    # fileType data dataSize                                            # Load music stream from data
isMusicReady                     ⇐ bool                    "IsMusicReady"                     _R⟨music⟩                                         # music                                                             # Checks if a music stream is ready
unloadMusicStream                ⇐                         "UnloadMusicStream"                _R⟨music⟩                                         # music                                                             # Unload music stream
playMusicStream                  ⇐                         "PlayMusicStream"                  _R⟨music⟩                                         # music                                                             # Start music playing
isMusicStreamPlaying             ⇐ bool                    "IsMusicStreamPlaying"             _R⟨music⟩                                         # music                                                             # Check if music is playing
updateMusicStream                ⇐                         "UpdateMusicStream"                _R⟨music⟩                                         # music                                                             # Updates buffers for music streaming
stopMusicStream                  ⇐                         "StopMusicStream"                  _R⟨music⟩                                         # music                                                             # Stop music playing
pauseMusicStream                 ⇐                         "PauseMusicStream"                 _R⟨music⟩                                         # music                                                             # Pause music playing
resumeMusicStream                ⇐                         "ResumeMusicStream"                _R⟨music⟩                                         # music                                                             # Resume playing paused music
seekMusicStream                  ⇐                         "SeekMusicStream"                  _R⟨music⋄f⟩                                       # music position                                                    # Seek music to a position (in seconds)
setMusicVolume                   ⇐                         "SetMusicVolume"                   _R⟨music⋄f⟩                                       # music volume                                                      # Set volume for music (1.0 is max level)
setMusicPitch                    ⇐                         "SetMusicPitch"                    _R⟨music⋄f⟩                                       # music pitch                                                       # Set pitch for a music (1.0 is base level)
setMusicPan                      ⇐                         "SetMusicPan"                      _R⟨music⋄f⟩                                       # music pan                                                         # Set pan for a music (0.5 is center)
getMusicTimeLength               ⇐ f                       "GetMusicTimeLength"               _R⟨music⟩                                         # music                                                             # Get music time length (in seconds)
getMusicTimePlayed               ⇐ f                       "GetMusicTimePlayed"               _R⟨music⟩                                         # music                                                             # Get current music time played (in seconds)
loadAudioStream                  ⇐ audioStream             "LoadAudioStream"                  _R⟨u⋄u⋄u⟩                                         # sampleRate sampleSize channels                                    # Load audio stream (to stream raw audio pcm data)
isAudioStreamReady               ⇐ bool                    "IsAudioStreamReady"               _R⟨audioStream⟩                                   # stream                                                            # Checks if an audio stream is ready
unloadAudioStream                ⇐                         "UnloadAudioStream"                _R⟨audioStream⟩                                   # stream                                                            # Unload audio stream and free memory
updateAudioStream                ⇐                         "UpdateAudioStream"                _R⟨audioStream⋄ptr⋄i⟩                             # stream data frameCount                                            # Update audio stream buffers with data
updateAudioStreamRaw             ⇐                         "UpdateAudioStream"                _R⟨audioStream⋄"*i8"⋄i⟩                           # stream data frameCount                                            # Update audio stream buffers with data
isAudioStreamProcessed           ⇐ bool                    "IsAudioStreamProcessed"           _R⟨audioStream⟩                                   # stream                                                            # Check if any audio stream buffers requires refill
playAudioStream                  ⇐                         "PlayAudioStream"                  _R⟨audioStream⟩                                   # stream                                                            # Play audio stream
pauseAudioStream                 ⇐                         "PauseAudioStream"                 _R⟨audioStream⟩                                   # stream                                                            # Pause audio stream
resumeAudioStream                ⇐                         "ResumeAudioStream"                _R⟨audioStream⟩                                   # stream                                                            # Resume audio stream
isAudioStreamPlaying             ⇐ bool                    "IsAudioStreamPlaying"             _R⟨audioStream⟩                                   # stream                                                            # Check if audio stream is playing
stopAudioStream                  ⇐                         "StopAudioStream"                  _R⟨audioStream⟩                                   # stream                                                            # Stop audio stream
setAudioStreamVolume             ⇐                         "SetAudioStreamVolume"             _R⟨audioStream⋄f⟩                                 # stream volume                                                     # Set volume for audio stream (1.0 is max level)
setAudioStreamPitch              ⇐                         "SetAudioStreamPitch"              _R⟨audioStream⋄f⟩                                 # stream pitch                                                      # Set pitch for audio stream (1.0 is base level)
setAudioStreamPan                ⇐                         "SetAudioStreamPan"                _R⟨audioStream⋄f⟩                                 # stream pan                                                        # Set pan for audio stream (0.5 is centered)
setAudioStreamBufferSizeDefault  ⇐                         "SetAudioStreamBufferSizeDefault"  _R⟨i⟩                                             # size                                                              # Default size for new audio streams
setAudioStreamCallback           ⇐                         "SetAudioStreamCallback"           _R⟨audioStream⋄ptr⟩                               # stream callback                                                   # Audio thread callback to request new data
attachAudioStreamProcessor       ⇐                         "AttachAudioStreamProcessor"       _R⟨audioStream⋄ptr⟩                               # stream processor                                                  # Attach audio stream processor to stream, receives the samples as <float>s
detachAudioStreamProcessor       ⇐                         "DetachAudioStreamProcessor"       _R⟨audioStream⋄ptr⟩                               # stream processor                                                  # Detach audio stream processor from stream
attachAudioMixedProcessor        ⇐                         "AttachAudioMixedProcessor"        _R⟨ptr⟩                                           # processor                                                         # Attach audio stream processor to the entire audio pipeline, receives the samples as <float>s
detachAudioMixedProcessor        ⇐                         "DetachAudioMixedProcessor"        _R⟨ptr⟩                                           # processor                                                         # Detach audio stream processor from the entire audio pipeline