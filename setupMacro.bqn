# Makes an importer that improves the ffi function creation syntax
MakeImporter ⇐ {𝕨𝕊pathToBin: debug←𝕨⊣0
  NestedStructToStr ← {
    1≥≡𝕩?𝕩;
    (m¬⊸/𝕩)∾'{'∾'}'«∾','∾¨𝕊¨𝕩/˜m←×≡¨𝕩
  }
  NestedStructToStrRet ← {
    1≥≡𝕩?𝕩;
    (m¬⊸/𝕩)∾'{'∾'}'«∾','∾¨𝕊¨"*"⍟("*i8:c8"⊸≡∨"*u8:c8"⊸≡)¨𝕩/˜m←×≡¨𝕩
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
    •term.Flush∘@∘•Out∘funcName⍟debug⊸⊢ {𝕏∾⟜@}⍟(a≡⋈'>'∾str) {𝕏∾⟜@¨⌾(m⊸/)}⍟(∨´m) func
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