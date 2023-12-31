# Binary can be any file with the extentions:
# ".dll" on windows, ".a" on mingw win32, ".so" on linux, and ".dylib" on macos
binaryFileLocation ← ⊑•args

# Makes an importer that improves the ffi function creation syntax
MakeImporter ⇐ {𝕨𝕊pathToBin: debug←𝕨⊣0
  NestedStructToStr ← {
    1≥≡𝕩?𝕩;
    IsPtr ← ("ustr"≡¯4⊸↑)∨('*'≡⊑)∨"str"≡¯3⊸↑
    (m¬⊸/𝕩)∾'{'∾'}'«∾','∾¨𝕊¨ptr⍟IsPtr⍟(⟨⟩≢≢)¨𝕩/˜m←×≡¨𝕩
  }

  {𝕨 funcName _𝕣 inpTypes: outType←𝕨⊣⟨⟩
    IntoStr ← NestedStructToStr
    a←'>'⊸∾⌾⊑⍟(1=≠) IntoStr¨𝕩
    HandleError ← {
      •Out "DEBUG TYPE INFO:"
      •Out •Fmt 𝕩
      •Out "END OF DEBUG TYPE INFO; BEGINING WITH FULL ERROR:"
      •term.Flush@
      𝕨•FFI𝕩
    }
    func ← pathToBin •FFI⎊HandleError ⟨ NestedStructToStr outType⋄funcName⟩∾a
    m ← str⊸≡¨a
    •term.Flush∘@∘•Out∘funcName⍟debug⊸⊢ {𝕏∾⟜@}⍟(a≡⋈'>'∾str) {𝕏∾⟜@¨⌾(m⊸/)}⍟(∨´m) func
  }
}

r ⇐ MakeImporter binaryFileLocation

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
ptr  ⇐ "*:i8"