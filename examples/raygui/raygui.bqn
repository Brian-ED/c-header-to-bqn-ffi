rAYGUI_VERSION_MAJOR ⇐ 4     #
rAYGUI_VERSION_MINOR ⇐ 0     #
rAYGUI_VERSION_PATCH ⇐ 0     #
rAYGUI_VERSION       ⇐ "4.0" #
sCROLLBAR_LEFT_SIDE  ⇐ 0     #
sCROLLBAR_RIGHT_SIDE ⇐ 1     #

guiState ⇐ { # Gui control state
  nORMAL   ⇐ 0  #
  fOCUSED  ⇐ 1  #
  pRESSED  ⇐ 2  #
  dISABLED ⇐ 3  #
}
guiTextAlignment ⇐ { # Gui control text alignment
  lEFT   ⇐ 0  #
  cENTER ⇐ 1  #
  rIGHT  ⇐ 2  #
}
guiTextAlignmentVertical ⇐ { # Gui control text alignment vertical
  tOP    ⇐ 0  #
  mIDDLE ⇐ 1  #
  bOTTOM ⇐ 2  #
}
guiTextWrapMode ⇐ { # Gui control text wrap mode
  nONE ⇐ 0  #
  cHAR ⇐ 1  #
  wORD ⇐ 2  #
}
guiControl ⇐ { # Gui controls
  dEFAULT     ⇐ 0   #
  lABEL       ⇐ 1   # Used also for: LABELBUTTON
  bUTTON      ⇐ 2   #
  tOGGLE      ⇐ 3   # Used also for: TOGGLEGROUP
  sLIDER      ⇐ 4   # Used also for: SLIDERBAR, TOGGLESLIDER
  pROGRESSBAR ⇐ 5   #
  cHECKBOX    ⇐ 6   #
  cOMBOBOX    ⇐ 7   #
  dROPDOWNBOX ⇐ 8   #
  tEXTBOX     ⇐ 9   # Used also for: TEXTBOXMULTI
  vALUEBOX    ⇐ 10  #
  sPINNER     ⇐ 11  # Uses: BUTTON, VALUEBOX
  lISTVIEW    ⇐ 12  #
  cOLORPICKER ⇐ 13  #
  sCROLLBAR   ⇐ 14  #
  sTATUSBAR   ⇐ 15  #
}
guiControlProperty ⇐ { # Gui base properties for every control
  bORDER_COLOR_NORMAL   ⇐ 0   # Control border color in STATE_NORMAL
  bASE_COLOR_NORMAL     ⇐ 1   # Control base color in STATE_NORMAL
  tEXT_COLOR_NORMAL     ⇐ 2   # Control text color in STATE_NORMAL
  bORDER_COLOR_FOCUSED  ⇐ 3   # Control border color in STATE_FOCUSED
  bASE_COLOR_FOCUSED    ⇐ 4   # Control base color in STATE_FOCUSED
  tEXT_COLOR_FOCUSED    ⇐ 5   # Control text color in STATE_FOCUSED
  bORDER_COLOR_PRESSED  ⇐ 6   # Control border color in STATE_PRESSED
  bASE_COLOR_PRESSED    ⇐ 7   # Control base color in STATE_PRESSED
  tEXT_COLOR_PRESSED    ⇐ 8   # Control text color in STATE_PRESSED
  bORDER_COLOR_DISABLED ⇐ 9   # Control border color in STATE_DISABLED
  bASE_COLOR_DISABLED   ⇐ 10  # Control base color in STATE_DISABLED
  tEXT_COLOR_DISABLED   ⇐ 11  # Control text color in STATE_DISABLED
  bORDER_WIDTH          ⇐ 12  # Control border size, 0 for no border
  tEXT_PADDING          ⇐ 13  # Control text padding, not considering border
  tEXT_ALIGNMENT        ⇐ 14  # Control text horizontal alignment inside control text bound (after border and padding)
}
guiDefaultProperty ⇐ { # DEFAULT extended properties
  tEXT_SIZE               ⇐ 16  # Text size (glyphs max height)
  tEXT_SPACING            ⇐ 17  # Text spacing between glyphs
  lINE_COLOR              ⇐ 18  # Line control color
  bACKGROUND_COLOR        ⇐ 19  # Background color
  tEXT_LINE_SPACING       ⇐ 20  # Text spacing between lines
  tEXT_ALIGNMENT_VERTICAL ⇐ 21  # Text vertical alignment inside text bounds (after border and padding)
  tEXT_WRAP_MODE          ⇐ 22  # Text wrap-mode inside text bounds
}
guiToggleProperty ⇐ { # Toggle/ToggleGroup
   ⇐ 16  # ToggleGroup separation between toggles
}
guiSliderProperty ⇐ { # Slider/SliderBar
  wIDTH   ⇐ 16  # Slider size of internal bar
  pADDING ⇐ 17  # Slider/SliderBar internal bar padding
}
guiProgressBarProperty ⇐ { # ProgressBar
   ⇐ 16  # ProgressBar internal padding
}
guiScrollBarProperty ⇐ { # ScrollBar
  aRROWS_SIZE           ⇐ 16  # ScrollBar arrows size
  aRROWS_VISIBLE        ⇐ 17  # ScrollBar arrows visible
  sCROLL_SLIDER_PADDING ⇐ 18  # ScrollBar slider internal padding
  sCROLL_SLIDER_SIZE    ⇐ 19  # ScrollBar slider size
  sCROLL_PADDING        ⇐ 20  # ScrollBar scroll padding from arrows
  sCROLL_SPEED          ⇐ 21  # ScrollBar scrolling speed
}
guiCheckBoxProperty ⇐ { # CheckBox
   ⇐ 16  # CheckBox internal check padding
}
guiComboBoxProperty ⇐ { # ComboBox
  wIDTH   ⇐ 16  # ComboBox right button width
  sPACING ⇐ 17  # ComboBox button separation
}
guiDropdownBoxProperty ⇐ { # DropdownBox
  aRROW_PADDING          ⇐ 16  # DropdownBox arrow separation from border and items
  dROPDOWN_ITEMS_SPACING ⇐ 17  # DropdownBox items separation
}
guiTextBoxProperty ⇐ { # TextBox/TextBoxMulti/ValueBox/Spinner
   ⇐ 16  # TextBox in read-only mode: 0-text editable, 1-text no-editable
}
guiSpinnerProperty ⇐ { # Spinner
  wIDTH   ⇐ 16  # Spinner left/right buttons width
  sPACING ⇐ 17  # Spinner buttons separation
}
guiListViewProperty ⇐ { # ListView
  lIST_ITEMS_HEIGHT  ⇐ 16  # ListView items height
  lIST_ITEMS_SPACING ⇐ 17  # ListView items separation
  sCROLLBAR_WIDTH    ⇐ 18  # ListView scrollbar size (usually width)
  sCROLLBAR_SIDE     ⇐ 19  # ListView scrollbar side (0-SCROLLBAR_LEFT_SIDE, 1-SCROLLBAR_RIGHT_SIDE)
}
guiColorPickerProperty ⇐ { # ColorPicker
  cOLOR_SELECTOR_SIZE      ⇐ 16  #
  hUEBAR_WIDTH             ⇐ 17  # ColorPicker right hue bar width
  hUEBAR_PADDING           ⇐ 18  # ColorPicker right hue bar separation from panel
  hUEBAR_SELECTOR_HEIGHT   ⇐ 19  # ColorPicker right hue bar selector height
  hUEBAR_SELECTOR_OVERFLOW ⇐ 20  # ColorPicker right hue bar selector overflow
}
guiIconName ⇐ { #
  nONE                    ⇐ 0    #
  fOLDER_FILE_OPEN        ⇐ 1    #
  fILE_SAVE_CLASSIC       ⇐ 2    #
  fOLDER_OPEN             ⇐ 3    #
  fOLDER_SAVE             ⇐ 4    #
  fILE_OPEN               ⇐ 5    #
  fILE_SAVE               ⇐ 6    #
  fILE_EXPORT             ⇐ 7    #
  fILE_ADD                ⇐ 8    #
  fILE_DELETE             ⇐ 9    #
  fILETYPE_TEXT           ⇐ 10   #
  fILETYPE_AUDIO          ⇐ 11   #
  fILETYPE_IMAGE          ⇐ 12   #
  fILETYPE_PLAY           ⇐ 13   #
  fILETYPE_VIDEO          ⇐ 14   #
  fILETYPE_INFO           ⇐ 15   #
  fILE_COPY               ⇐ 16   #
  fILE_CUT                ⇐ 17   #
  fILE_PASTE              ⇐ 18   #
  cURSOR_HAND             ⇐ 19   #
  cURSOR_POINTER          ⇐ 20   #
  cURSOR_CLASSIC          ⇐ 21   #
  pENCIL                  ⇐ 22   #
  pENCIL_BIG              ⇐ 23   #
  bRUSH_CLASSIC           ⇐ 24   #
  bRUSH_PAINTER           ⇐ 25   #
  wATER_DROP              ⇐ 26   #
  cOLOR_PICKER            ⇐ 27   #
  rUBBER                  ⇐ 28   #
  cOLOR_BUCKET            ⇐ 29   #
  tEXT_T                  ⇐ 30   #
  tEXT_A                  ⇐ 31   #
  sCALE                   ⇐ 32   #
  rESIZE                  ⇐ 33   #
  fILTER_POINT            ⇐ 34   #
  fILTER_BILINEAR         ⇐ 35   #
  cROP                    ⇐ 36   #
  cROP_ALPHA              ⇐ 37   #
  sQUARE_TOGGLE           ⇐ 38   #
  sYMMETRY                ⇐ 39   #
  sYMMETRY_HORIZONTAL     ⇐ 40   #
  sYMMETRY_VERTICAL       ⇐ 41   #
  lENS                    ⇐ 42   #
  lENS_BIG                ⇐ 43   #
  eYE_ON                  ⇐ 44   #
  eYE_OFF                 ⇐ 45   #
  fILTER_TOP              ⇐ 46   #
  fILTER                  ⇐ 47   #
  tARGET_POINT            ⇐ 48   #
  tARGET_SMALL            ⇐ 49   #
  tARGET_BIG              ⇐ 50   #
  tARGET_MOVE             ⇐ 51   #
  cURSOR_MOVE             ⇐ 52   #
  cURSOR_SCALE            ⇐ 53   #
  cURSOR_SCALE_RIGHT      ⇐ 54   #
  cURSOR_SCALE_LEFT       ⇐ 55   #
  uNDO                    ⇐ 56   #
  rEDO                    ⇐ 57   #
  rEREDO                  ⇐ 58   #
  mUTATE                  ⇐ 59   #
  rOTATE                  ⇐ 60   #
  rEPEAT                  ⇐ 61   #
  sHUFFLE                 ⇐ 62   #
  eMPTYBOX                ⇐ 63   #
  tARGET                  ⇐ 64   #
  tARGET_SMALL_FILL       ⇐ 65   #
  tARGET_BIG_FILL         ⇐ 66   #
  tARGET_MOVE_FILL        ⇐ 67   #
  cURSOR_MOVE_FILL        ⇐ 68   #
  cURSOR_SCALE_FILL       ⇐ 69   #
  cURSOR_SCALE_RIGHT_FILL ⇐ 70   #
  cURSOR_SCALE_LEFT_FILL  ⇐ 71   #
  uNDO_FILL               ⇐ 72   #
  rEDO_FILL               ⇐ 73   #
  rEREDO_FILL             ⇐ 74   #
  mUTATE_FILL             ⇐ 75   #
  rOTATE_FILL             ⇐ 76   #
  rEPEAT_FILL             ⇐ 77   #
  sHUFFLE_FILL            ⇐ 78   #
  eMPTYBOX_SMALL          ⇐ 79   #
  bOX                     ⇐ 80   #
  bOX_TOP                 ⇐ 81   #
  bOX_TOP_RIGHT           ⇐ 82   #
  bOX_RIGHT               ⇐ 83   #
  bOX_BOTTOM_RIGHT        ⇐ 84   #
  bOX_BOTTOM              ⇐ 85   #
  bOX_BOTTOM_LEFT         ⇐ 86   #
  bOX_LEFT                ⇐ 87   #
  bOX_TOP_LEFT            ⇐ 88   #
  bOX_CENTER              ⇐ 89   #
  bOX_CIRCLE_MASK         ⇐ 90   #
  pOT                     ⇐ 91   #
  aLPHA_MULTIPLY          ⇐ 92   #
  aLPHA_CLEAR             ⇐ 93   #
  dITHERING               ⇐ 94   #
  mIPMAPS                 ⇐ 95   #
  bOX_GRID                ⇐ 96   #
  gRID                    ⇐ 97   #
  bOX_CORNERS_SMALL       ⇐ 98   #
  bOX_CORNERS_BIG         ⇐ 99   #
  fOUR_BOXES              ⇐ 100  #
  gRID_FILL               ⇐ 101  #
  bOX_MULTISIZE           ⇐ 102  #
  zOOM_SMALL              ⇐ 103  #
  zOOM_MEDIUM             ⇐ 104  #
  zOOM_BIG                ⇐ 105  #
  zOOM_ALL                ⇐ 106  #
  zOOM_CENTER             ⇐ 107  #
  bOX_DOTS_SMALL          ⇐ 108  #
  bOX_DOTS_BIG            ⇐ 109  #
  bOX_CONCENTRIC          ⇐ 110  #
  bOX_GRID_BIG            ⇐ 111  #
  oK_TICK                 ⇐ 112  #
  cROSS                   ⇐ 113  #
  aRROW_LEFT              ⇐ 114  #
  aRROW_RIGHT             ⇐ 115  #
  aRROW_DOWN              ⇐ 116  #
  aRROW_UP                ⇐ 117  #
  aRROW_LEFT_FILL         ⇐ 118  #
  aRROW_RIGHT_FILL        ⇐ 119  #
  aRROW_DOWN_FILL         ⇐ 120  #
  aRROW_UP_FILL           ⇐ 121  #
  aUDIO                   ⇐ 122  #
  fX                      ⇐ 123  #
  wAVE                    ⇐ 124  #
  wAVE_SINUS              ⇐ 125  #
  wAVE_SQUARE             ⇐ 126  #
  wAVE_TRIANGULAR         ⇐ 127  #
  cROSS_SMALL             ⇐ 128  #
  pLAYER_PREVIOUS         ⇐ 129  #
  pLAYER_PLAY_BACK        ⇐ 130  #
  pLAYER_PLAY             ⇐ 131  #
  pLAYER_PAUSE            ⇐ 132  #
  pLAYER_STOP             ⇐ 133  #
  pLAYER_NEXT             ⇐ 134  #
  pLAYER_RECORD           ⇐ 135  #
  mAGNET                  ⇐ 136  #
  lOCK_CLOSE              ⇐ 137  #
  lOCK_OPEN               ⇐ 138  #
  cLOCK                   ⇐ 139  #
  tOOLS                   ⇐ 140  #
  gEAR                    ⇐ 141  #
  gEAR_BIG                ⇐ 142  #
  bIN                     ⇐ 143  #
  hAND_POINTER            ⇐ 144  #
  lASER                   ⇐ 145  #
  cOIN                    ⇐ 146  #
  eXPLOSION               ⇐ 147  #
  1UP                     ⇐ 148  #
  pLAYER                  ⇐ 149  #
  pLAYER_JUMP             ⇐ 150  #
  kEY                     ⇐ 151  #
  dEMON                   ⇐ 152  #
  tEXT_POPUP              ⇐ 153  #
  gEAR_EX                 ⇐ 154  #
  cRACK                   ⇐ 155  #
  cRACK_POINTS            ⇐ 156  #
  sTAR                    ⇐ 157  #
  dOOR                    ⇐ 158  #
  eXIT                    ⇐ 159  #
  mODE_2D                 ⇐ 160  #
  mODE_3D                 ⇐ 161  #
  cUBE                    ⇐ 162  #
  cUBE_FACE_TOP           ⇐ 163  #
  cUBE_FACE_LEFT          ⇐ 164  #
  cUBE_FACE_FRONT         ⇐ 165  #
  cUBE_FACE_BOTTOM        ⇐ 166  #
  cUBE_FACE_RIGHT         ⇐ 167  #
  cUBE_FACE_BACK          ⇐ 168  #
  cAMERA                  ⇐ 169  #
  sPECIAL                 ⇐ 170  #
  lINK_NET                ⇐ 171  #
  lINK_BOXES              ⇐ 172  #
  lINK_MULTI              ⇐ 173  #
  lINK                    ⇐ 174  #
  lINK_BROKE              ⇐ 175  #
  tEXT_NOTES              ⇐ 176  #
  nOTEBOOK                ⇐ 177  #
  sUITCASE                ⇐ 178  #
  sUITCASE_ZIP            ⇐ 179  #
  mAILBOX                 ⇐ 180  #
  mONITOR                 ⇐ 181  #
  pRINTER                 ⇐ 182  #
  pHOTO_CAMERA            ⇐ 183  #
  pHOTO_CAMERA_FLASH      ⇐ 184  #
  hOUSE                   ⇐ 185  #
  hEART                   ⇐ 186  #
  cORNER                  ⇐ 187  #
  vERTICAL_BARS           ⇐ 188  #
  vERTICAL_BARS_FILL      ⇐ 189  #
  lIFE_BARS               ⇐ 190  #
  iNFO                    ⇐ 191  #
  cROSSLINE               ⇐ 192  #
  hELP                    ⇐ 193  #
  fILETYPE_ALPHA          ⇐ 194  #
  fILETYPE_HOME           ⇐ 195  #
  lAYERS_VISIBLE          ⇐ 196  #
  lAYERS                  ⇐ 197  #
  wINDOW                  ⇐ 198  #
  hIDPI                   ⇐ 199  #
  fILETYPE_BINARY         ⇐ 200  #
  hEX                     ⇐ 201  #
  sHIELD                  ⇐ 202  #
  fILE_NEW                ⇐ 203  #
  fOLDER_ADD              ⇐ 204  #
  aLARM                   ⇐ 205  #
  cPU                     ⇐ 206  #
  rOM                     ⇐ 207  #
  sTEP_OVER               ⇐ 208  #
  sTEP_INTO               ⇐ 209  #
  sTEP_OUT                ⇐ 210  #
  rESTART                 ⇐ 211  #
  bREAKPOINT_ON           ⇐ 212  #
  bREAKPOINT_OFF          ⇐ 213  #
  bURGER_MENU             ⇐ 214  #
  cASE_SENSITIVE          ⇐ 215  #
  rEG_EXP                 ⇐ 216  #
  fOLDER                  ⇐ 217  #
  fILE                    ⇐ 218  #
  sAND_TIMER              ⇐ 219  #
  220                     ⇐ 220  #
  221                     ⇐ 221  #
  222                     ⇐ 222  #
  223                     ⇐ 223  #
  224                     ⇐ 224  #
  225                     ⇐ 225  #
  226                     ⇐ 226  #
  227                     ⇐ 227  #
  228                     ⇐ 228  #
  229                     ⇐ 229  #
  230                     ⇐ 230  #
  231                     ⇐ 231  #
  232                     ⇐ 232  #
  233                     ⇐ 233  #
  234                     ⇐ 234  #
  235                     ⇐ 235  #
  236                     ⇐ 236  #
  237                     ⇐ 237  #
  238                     ⇐ 238  #
  239                     ⇐ 239  #
  240                     ⇐ 240  #
  241                     ⇐ 241  #
  242                     ⇐ 242  #
  243                     ⇐ 243  #
  244                     ⇐ 244  #
  245                     ⇐ 245  #
  246                     ⇐ 246  #
  247                     ⇐ 247  #
  248                     ⇐ 248  #
  249                     ⇐ 249  #
  250                     ⇐ 250  #
  251                     ⇐ 251  #
  252                     ⇐ 252  #
  253                     ⇐ 253  #
  254                     ⇐ 254  #
  255                     ⇐ 255  #
}

v2 ⇐ ⟨ # Vector2 type
  f # x  #
  f # y  #
⟩
v3 ⇐ ⟨ # Vector3 type                 // -- ConvertHSVtoRGB(), ConvertRGBtoHSV()
  f # x  #
  f # y  #
  f # z  #
⟩
color ⇐ ⟨ # Color type, RGBA (32bit)
  u8 # r  #
  u8 # g  #
  u8 # b  #
  u8 # a  #
⟩
rectangle ⇐ ⟨ # Rectangle type
  f # x       #
  f # y       #
  f # width   #
  f # height  #
⟩
texture2D ⇐ ⟨ # It should be redesigned to be provided by user
  u # id       # OpenGL texture id
  i # width    # Texture base width
  i # height   # Texture base height
  i # mipmaps  # Mipmap levels, 1 by default
  i # format   # Data format (PixelFormat type)
⟩
image ⇐ ⟨ # Image, pixel data stored in CPU memory (RAM)
  ptr # data     # Image raw data
  i   # width    # Image base width
  i   # height   # Image base height
  i   # mipmaps  # Mipmap levels, 1 by default
  i   # format   # Data format (PixelFormat type)
⟩
glyphInfo ⇐ ⟨ # GlyphInfo, font characters glyphs info
  i     # value     # Character value (Unicode)
  i     # offsetX   # Character offset X when drawing
  i     # offsetY   # Character offset Y when drawing
  i     # advanceX  # Character advance position X
  image # image     # Character image data
⟩
font ⇐ ⟨ # It should be redesigned to be provided by user
  i             # baseSize      # Base size (default chars height)
  i             # glyphCount    # Number of glyph characters
  i             # glyphPadding  # Padding around the glyph characters
  texture2D     # texture       # Texture atlas containing the glyphs
  "*"∾rectangle # recs          # Rectangles in texture for the glyphs
  "*"∾glyphInfo # glyphs        # Glyphs info data
⟩
guiStyleProp ⇐ ⟨ # NOTE: Used when exporting style as code for convenience
  "u16" # controlId      # Control identifier
  "u16" # propertyId     # Property identifier
  i     # propertyValue  # Property value
⟩
guiTextStyle ⇐ ⟨ # NOTE: Text style is defined by control
  u # size         #
  i # charSpacing  #
  i # lineSpacing  #
  i # alignmentH   #
  i # alignmentV   #
  i # padding      #
⟩
