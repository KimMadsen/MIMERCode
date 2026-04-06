// MimerCode Higher-Order Functions Test Suite
// Tests: filter, map, reduce, any, all, sorted, reversed, enumerate, zip
// Copyright 2026 Components4Developers - Kim Bo Madsen
// Run with: MimerCodeRunner functional.mc

program FunctionalTest

  WriteLn("=== Higher-Order Functions Tests ===")
  WriteLn("")

  // -------------------------------------------------------
  // 1. filter - keep elements matching a predicate
  // -------------------------------------------------------
  WriteLn("1. filter:")

  local Numbers := [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  local Evens := filter(Numbers, lambda(X: Integer) -> Boolean
    return X mod 2 = 0
  end)
  WriteLn(f"  Evens: {Evens}")
  // Expected: [2, 4, 6, 8, 10]

  local BigOnes := filter(Numbers, lambda(X: Integer) -> Boolean
    return X > 5
  end)
  WriteLn(f"  > 5: {BigOnes}")
  // Expected: [6, 7, 8, 9, 10]

  local Words := ["hello", "hi", "world", "hey", "help"]
  local HWords := filter(Words, lambda(W: String) -> Boolean
    return W.StartsWith("h")
  end)
  WriteLn(f"  H-words: {HWords}")
  // Expected: [hello, hi, hey, help]
  WriteLn("")

  // -------------------------------------------------------
  // 2. map - transform each element
  // -------------------------------------------------------
  WriteLn("2. map:")

  local Doubled := map(Numbers, lambda(X: Integer) -> Integer
    return X * 2
  end)
  WriteLn(f"  Doubled: {Doubled}")
  // Expected: [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

  local Names := ["alice", "bob", "charlie"]
  local Upper := map(Names, lambda(S: String) -> String
    return S.ToUpper()
  end)
  WriteLn(f"  Uppercased: {Upper}")
  // Expected: [ALICE, BOB, CHARLIE]

  local Lengths := map(Names, lambda(S: String) -> Integer
    return Length(S)
  end)
  WriteLn(f"  Lengths: {Lengths}")
  // Expected: [5, 3, 7]
  WriteLn("")

  // -------------------------------------------------------
  // 3. reduce - accumulate to single value
  // -------------------------------------------------------
  WriteLn("3. reduce:")

  local Sum := reduce(Numbers, lambda(Acc: Integer, X: Integer) -> Integer
    return Acc + X
  end, 0)
  WriteLn(f"  Sum 1..10: {Sum}")
  // Expected: 55

  local Product := reduce([1, 2, 3, 4, 5], lambda(Acc: Integer, X: Integer) -> Integer
    return Acc * X
  end, 1)
  WriteLn(f"  Product 1..5: {Product}")
  // Expected: 120

  // reduce without initial value (uses first element)
  local MaxVal := reduce(Numbers, lambda(Acc: Integer, X: Integer) -> Integer
    if X > Acc then
      return X
    end
    return Acc
  end)
  WriteLn(f"  Max of 1..10: {MaxVal}")
  // Expected: 10

  // String concatenation with reduce
  local Joined := reduce(Names, lambda(Acc: String, S: String) -> String
    return Acc + ", " + S
  end)
  WriteLn(f"  Joined: {Joined}")
  // Expected: alice, bob, charlie
  WriteLn("")

  // -------------------------------------------------------
  // 4. any / all - predicate testing
  // -------------------------------------------------------
  WriteLn("4. any / all:")

  local HasNeg := any([-1, 2, 3], lambda(X: Integer) -> Boolean
    return X < 0
  end)
  WriteLn(f"  any([-1,2,3], < 0): {HasNeg}")
  // Expected: True

  local AllPos := all([1, 2, 3], lambda(X: Integer) -> Boolean
    return X > 0
  end)
  WriteLn(f"  all([1,2,3], > 0): {AllPos}")
  // Expected: True

  local AllBig := all([1, 2, 3], lambda(X: Integer) -> Boolean
    return X > 2
  end)
  WriteLn(f"  all([1,2,3], > 2): {AllBig}")
  // Expected: False
  WriteLn("")

  // -------------------------------------------------------
  // 5. sorted - with and without comparator
  // -------------------------------------------------------
  WriteLn("5. sorted:")

  local Unsorted := [5, 2, 8, 1, 9, 3]

  local AscSort := sorted(Unsorted)
  WriteLn(f"  Default sort: {AscSort}")
  // Expected: [1, 2, 3, 5, 8, 9]

  local DescSort := sorted(Unsorted, lambda(A: Integer, B: Integer) -> Integer
    return B - A
  end)
  WriteLn(f"  Descending: {DescSort}")
  // Expected: [9, 8, 5, 3, 2, 1]

  local NamesSorted := sorted(["charlie", "alice", "bob"])
  WriteLn(f"  Names sorted: {NamesSorted}")
  // Expected: [alice, bob, charlie]

  // Sort by string length
  local ByLength := sorted(["hi", "hello", "hey", "greetings"], lambda(A: String, B: String) -> Integer
    return Length(A) - Length(B)
  end)
  WriteLn(f"  By length: {ByLength}")
  // Expected: [hi, hey, hello, greetings]
  WriteLn("")

  // -------------------------------------------------------
  // 6. reversed
  // -------------------------------------------------------
  WriteLn("6. reversed:")

  local Rev := reversed([1, 2, 3, 4, 5])
  WriteLn(f"  reversed([1..5]): {Rev}")
  // Expected: [5, 4, 3, 2, 1]

  local RevWords := reversed(["a", "b", "c"])
  WriteLn(f"  reversed words: {RevWords}")
  // Expected: [c, b, a]
  WriteLn("")

  // -------------------------------------------------------
  // 7. enumerate - (index, value) pairs
  // -------------------------------------------------------
  WriteLn("7. enumerate:")

  local Colors := ["red", "green", "blue"]
  local Indexed := enumerate(Colors)
  for Pair in Indexed do
    WriteLn(f"  [{Pair[0]}] = {Pair[1]}")
  end
  // Expected: [0] = red, [1] = green, [2] = blue
  WriteLn("")

  // -------------------------------------------------------
  // 8. zip - pair elements from two arrays
  // -------------------------------------------------------
  WriteLn("8. zip:")

  local Keys := ["name", "age", "city"]
  local Vals := ["Alice", "30", "Copenhagen"]
  local Pairs := zip(Keys, Vals)
  for P in Pairs do
    WriteLn(f"  {P[0]}: {P[1]}")
  end
  // Expected: name: Alice, age: 30, city: Copenhagen
  WriteLn("")

  // Zip with different lengths (truncates to shorter)
  local Short := zip([1, 2, 3], ["a", "b"])
  WriteLn(f"  zip([1,2,3], [a,b]): count={Length(Short)}")
  // Expected: 2
  WriteLn("")

  // -------------------------------------------------------
  // 9. Chaining: filter + map + reduce
  // -------------------------------------------------------
  WriteLn("9. Chaining (filter + map + reduce):")

  // Sum of squares of even numbers from 1 to 10
  local Data := [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  local EvenData := filter(Data, lambda(X: Integer) -> Boolean
    return X mod 2 = 0
  end)

  local Squared := map(EvenData, lambda(X: Integer) -> Integer
    return X * X
  end)

  local Total := reduce(Squared, lambda(Acc: Integer, X: Integer) -> Integer
    return Acc + X
  end, 0)

  WriteLn(f"  Even numbers: {EvenData}")
  WriteLn(f"  Squared: {Squared}")
  WriteLn(f"  Sum of squares of evens: {Total}")
  // Expected: [2,4,6,8,10] -> [4,16,36,64,100] -> 220
  WriteLn("")

  // -------------------------------------------------------
  // 10. Practical: word frequency count
  // -------------------------------------------------------
  WriteLn("10. Word frequency count:")

  local Text := "the cat sat on the mat the cat"
  local WordList := Text.Split(" ")
  WriteLn(f"  Words: {WordList}")

  // Count using defaultdict behavior (dict returns 0 for missing keys)
  local Freq := dict {}
  for W in WordList do
    Freq[W] := Freq[W] + 1
  end

  WriteLn(f"  Frequencies: {Freq}")
  // Expected: {the: 3, cat: 2, sat: 1, on: 1, mat: 1}
  WriteLn("")

  WriteLn("=== All Higher-Order Function Tests Complete ===")

end
