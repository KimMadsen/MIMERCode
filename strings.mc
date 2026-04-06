// MimerCode Sample - String Utilities
// Copyright 2026 Components4Developers - Kim Bo Madsen
// Run with: MimerCodeRunner strings.mc

program StringUtils

  // --- Reverse a string ---
  func ReverseStr(const S: String) -> String
    local Result: String = ''
    for I := Length(S) - 1 downto 0 do
      Result += Copy(S, I, 1)
    end
    return Result
  end

  // --- Check if palindrome ---
  func IsPalindrome(const S: String) -> Boolean
    local Lower: String
    Lower := LowerCase(S)
    return Lower = ReverseStr(Lower)
  end

  // --- Count occurrences of a character ---
  func CountChar(const S: String, const C: String) -> Integer
    local Count: Integer = 0
    for I := 0 to Length(S) - 1 do
      if Copy(S, I, 1) = C then
        Count += 1
      end
    end
    return Count
  end

  // --- Simple Caesar cipher ---
  func Caesar(const Text: String, Shift: Integer) -> String
    local Result: String = ''
    local Ch: Integer
    local Base: Integer
    for I := 0 to Length(Text) - 1 do
      Ch := Ord(Copy(Text, I, 1))
      if (Ch >= 65) and (Ch <= 90) then
        // Uppercase A-Z
        Base := ((Ch - 65) + Shift) mod 26
        if Base < 0 then
          Base += 26
        end
        Result += Chr(Base + 65)
      elif (Ch >= 97) and (Ch <= 122) then
        // Lowercase a-z
        Base := ((Ch - 97) + Shift) mod 26
        if Base < 0 then
          Base += 26
        end
        Result += Chr(Base + 97)
      else
        Result += Chr(Ch)
      end
    end
    return Result
  end

  // --- Word count ---
  func WordCount(const S: String) -> Integer
    local Count: Integer = 0
    local InWord: Boolean = False
    local Ch: String
    for I := 0 to Length(S) - 1 do
      Ch := Copy(S, I, 1)
      if (Ch = ' ') or (Ch = Chr(9)) then
        InWord := False
      else
        if not InWord then
          Count += 1
          InWord := True
        end
      end
    end
    return Count
  end

  // --- Demos ---
  WriteLn('=== String Utilities ===')
  WriteLn('')

  WriteLn('Reverse:')
  WriteLn(f'  "Hello" -> "{ReverseStr("Hello")}"')
  WriteLn(f'  "MimerCode" -> "{ReverseStr("MimerCode")}"')
  WriteLn('')

  WriteLn('Palindrome check:')
  local Words: TArray<String>
  Words := ['racecar', 'hello', 'madam', 'world', 'level', 'kayak']
  for W in Words do
    if IsPalindrome(W) then
      WriteLn(f'  "{W}" is a palindrome')
    else
      WriteLn(f'  "{W}" is NOT a palindrome')
    end
  end
  WriteLn('')

  WriteLn('Character counting:')
  local Sentence: String = 'Mississippi'
  WriteLn(f'  "{Sentence}" has {CountChar(Sentence, "s")} lowercase s characters')
  WriteLn(f'  "{Sentence}" has {CountChar(Sentence, "i")} lowercase i characters')
  WriteLn('')

  WriteLn('Caesar cipher:')
  local Plain: String = 'Hello World'
  local Encrypted: String
  Encrypted := Caesar(Plain, 3)
  local Decrypted: String
  Decrypted := Caesar(Encrypted, -3)
  WriteLn(f'  Plain:     "{Plain}"')
  WriteLn(f'  Encrypted: "{Encrypted}"')
  WriteLn(f'  Decrypted: "{Decrypted}"')
  WriteLn('')

  WriteLn('Word count:')
  local Text: String = 'The quick brown fox jumps over the lazy dog'
  WriteLn(f'  "{Text}"')
  WriteLn(f'  Words: {WordCount(Text)}')

end
