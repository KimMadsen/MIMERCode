// MimerCode Generics Test Suite
// Tests: generic classes, generic records, generic collections, type parameters
// Copyright 2026 Components4Developers - Kim Bo Madsen
// Run with: MimerCodeRunner generics.mc

program GenericsTest

  WriteLn("=== MimerCode Generics Tests ===")
  WriteLn("")

  // -------------------------------------------------------
  // 1. Generic Stack class
  // -------------------------------------------------------
  WriteLn("1. Generic Stack<T> class:")

  class TStack<T>(TObject)
    private
      field FItems: TArray<T>
      field FCount: Integer
    public
      constructor Create()
        FItems := []
        FCount := 0
      end

      func Push(const AItem: T)
        FItems[FCount] := AItem
        FCount := FCount + 1
      end

      func Pop() -> T
        if FCount = 0 then
          return nil
        end
        FCount := FCount - 1
        return FItems[FCount]
      end

      func Peek() -> T
        if FCount = 0 then
          return nil
        end
        return FItems[FCount - 1]
      end

      func GetCount() -> Integer
        return FCount
      end

      func IsEmpty() -> Boolean
        return FCount = 0
      end

      func ToString() -> String
        local LResult: String
        LResult := "Stack["
        for I := 0 to FCount - 1 do
          if I > 0 then
            LResult := LResult + ", "
          end
          LResult := LResult + f"{FItems[I]}"
        end
        LResult := LResult + "]"
        return LResult
      end
    end
  end

  // Use with integers
  var IntStack := create TStack<Integer>()
  IntStack.Push(10)
  IntStack.Push(20)
  IntStack.Push(30)
  WriteLn(f"  IntStack: {IntStack.ToString()}")
  WriteLn(f"  Peek: {IntStack.Peek()}")
  WriteLn(f"  Pop: {IntStack.Pop()}")
  WriteLn(f"  After pop: {IntStack.ToString()}")
  WriteLn(f"  Count: {IntStack.GetCount()}")
  free IntStack

  // Use with strings
  var StrStack := create TStack<String>()
  StrStack.Push("hello")
  StrStack.Push("world")
  StrStack.Push("!")
  WriteLn(f"  StrStack: {StrStack.ToString()}")
  WriteLn(f"  Pop: {StrStack.Pop()}")
  WriteLn(f"  After pop: {StrStack.ToString()}")
  free StrStack
  WriteLn("")

  // -------------------------------------------------------
  // 2. Generic Pair record
  // -------------------------------------------------------
  WriteLn("2. Generic Pair<K,V> record:")

  record TPair<K, V>
    field Key: K
    field Value: V

    func ToString() -> String
      return f"{Key} -> {Value}"
    end
  end

  var P1 := create TPair<String, Integer>("age", 30)
  var P2 := create TPair<String, String>("name", "Alice")
  WriteLn(f"  P1: {P1.ToString()}")
  WriteLn(f"  P2: {P2.ToString()}")
  WriteLn("  P1.Key = " + P1.Key + ", P1.Value = " + IntToStr(P1.Value))
  free P1
  free P2
  WriteLn("")

  // -------------------------------------------------------
  // 3. Generic Queue class (FIFO)
  // -------------------------------------------------------
  WriteLn("3. Generic Queue<T> class (FIFO):")

  class TQueue<T>(TObject)
    private
      field FItems: TArray<T>
      field FHead: Integer
      field FTail: Integer
    public
      constructor Create()
        FItems := []
        FHead := 0
        FTail := 0
      end

      func Enqueue(const AItem: T)
        FItems[FTail] := AItem
        FTail := FTail + 1
      end

      func Dequeue() -> T
        if FHead >= FTail then
          return nil
        end
        local LResult := FItems[FHead]
        FHead := FHead + 1
        return LResult
      end

      func GetCount() -> Integer
        return FTail - FHead
      end

      func ToString() -> String
        local LResult: String
        LResult := "Queue("
        for I := FHead to FTail - 1 do
          if I > FHead then
            LResult := LResult + ", "
          end
          LResult := LResult + f"{FItems[I]}"
        end
        LResult := LResult + ")"
        return LResult
      end
    end
  end

  var Q := create TQueue<String>()
  Q.Enqueue("first")
  Q.Enqueue("second")
  Q.Enqueue("third")
  WriteLn(f"  Queue: {Q.ToString()}")
  WriteLn(f"  Dequeue: {Q.Dequeue()}")
  WriteLn(f"  Dequeue: {Q.Dequeue()}")
  WriteLn(f"  After 2 dequeues: {Q.ToString()}")
  WriteLn(f"  Count: {Q.GetCount()}")
  free Q
  WriteLn("")

  // -------------------------------------------------------
  // 4. Generic wrapper with properties
  // -------------------------------------------------------
  WriteLn("4. Generic Box<T> with properties:")

  class TBox<T>(TObject)
    private
      field FValue: T
      field FLabel: String
    public
      constructor Create(const ALabel: String, AValue: T)
        FLabel := ALabel
        FValue := AValue
      end

      func GetValue() -> T
        return FValue
      end

      func SetValue(AValue: T)
        FValue := AValue
      end

      func ToString() -> String
        return f"{FLabel}: {FValue}"
      end

      prop Value: T read GetValue write SetValue
    end
  end

  var IntBox := create TBox<Integer>("count", 42)
  WriteLn(f"  {IntBox.ToString()}")
  IntBox.Value := 100
  WriteLn(f"  After set: {IntBox.ToString()}")
  free IntBox

  var StrBox := create TBox<String>("greeting", "hello")
  WriteLn(f"  {StrBox.ToString()}")
  StrBox.Value := "goodbye"
  WriteLn(f"  After set: {StrBox.ToString()}")
  free StrBox
  WriteLn("")

  // -------------------------------------------------------
  // 5. Built-in generic collections
  // -------------------------------------------------------
  WriteLn("5. Built-in generic collections:")

  local Scores: TDictionary<String, Integer>
  Scores := dict {"Alice": 95, "Bob": 87, "Charlie": 92}
  WriteLn(f"  Scores: {Scores}")
  WriteLn(f"  Alice: {Scores['Alice']}")

  local Names: TList<String>
  Names := ["Alice", "Bob", "Charlie"]
  WriteLn(f"  Names: {Names}")
  WriteLn(f"  Count: {Length(Names)}")
  WriteLn("")

  // -------------------------------------------------------
  // 6. Generic range record with comparisons
  // -------------------------------------------------------
  WriteLn("6. Generic range record:")

  record TRange<T>
    field Min: T
    field Max: T

    func Contains(AValue: T) -> Boolean
      return (AValue >= Min) and (AValue <= Max)
    end

    func ToString() -> String
      return f"[{Min}..{Max}]"
    end
  end

  var IntRange := create TRange<Integer>(1, 100)
  WriteLn(f"  Range: {IntRange.ToString()}")
  WriteLn(f"  Contains 50: {IntRange.Contains(50)}")
  WriteLn(f"  Contains 150: {IntRange.Contains(150)}")
  WriteLn(f"  Contains 1: {IntRange.Contains(1)}")
  free IntRange

  var FloatRange := create TRange<Double>(0.0, 1.0)
  WriteLn(f"  Float range: {FloatRange.ToString()}")
  WriteLn(f"  Contains 0.5: {FloatRange.Contains(0.5)}")
  WriteLn(f"  Contains 1.5: {FloatRange.Contains(1.5)}")
  free FloatRange
  WriteLn("")

  // -------------------------------------------------------
  // 7. Array operators: +, -, *
  // -------------------------------------------------------
  WriteLn("7. Array operators (+, -, *):")

  local A: TArray<Integer>
  local B: TArray<Integer>
  A := [1, 2, 3]
  B := [4, 5, 6]
  local C := A + B
  WriteLn(f"  [1,2,3] + [4,5,6] = {C}")

  local Words := ["hello"] + ["world"] + ["!"]
  WriteLn(f"  Concat words: {Words}")

  // Array difference: items in left not in right
  local D1 := [1, 2, 3, 4, 5] - [2, 4]
  WriteLn(f"  [1,2,3,4,5] - [2,4] = {D1}")

  local D2 := ["apple", "banana", "cherry", "date"] - ["banana", "date"]
  WriteLn(f"  Fruit diff: {D2}")

  // Array intersection: items in both
  local I1 := [1, 2, 3, 4, 5] * [2, 4, 6]
  WriteLn(f"  [1,2,3,4,5] * [2,4,6] = {I1}")

  local I2 := ["red", "green", "blue"] * ["green", "blue", "yellow"]
  WriteLn(f"  Color intersect: {I2}")

  // Chained: keep items from A that are also in B, then remove C
  local X := [1, 2, 3, 4, 5, 6, 7, 8]
  local Y := [2, 4, 6, 8, 10]
  local Z := [4, 8]
  local XY := (X * Y) - Z
  WriteLn(f"  ([1..8] * [2,4,6,8,10]) - [4,8] = {XY}")
  WriteLn("")

  // -------------------------------------------------------
  // 8. Array methods: Add, Remove, IndexOf, Contains, etc
  // -------------------------------------------------------
  WriteLn("8. Array methods:")

  local Arr: TArray<Integer>
  Arr := [10, 20, 30]
  WriteLn(f"  Initial: {Arr}")

  Arr.Add(40)
  WriteLn(f"  After Add(40): {Arr}")

  Arr.Insert(1, 15)
  WriteLn(f"  After Insert(1, 15): {Arr}")

  Arr.Remove(0)
  WriteLn(f"  After Remove(0): {Arr}")

  WriteLn(f"  IndexOf(30): {Arr.IndexOf(30)}")
  WriteLn(f"  IndexOf(99): {Arr.IndexOf(99)}")
  WriteLn(f"  Contains(20): {Arr.Contains(20)}")
  WriteLn(f"  Contains(99): {Arr.Contains(99)}")

  local Popped := Arr.Pop()
  WriteLn(f"  Pop(): {Popped}")
  WriteLn(f"  After Pop: {Arr}")

  Arr.Reverse()
  WriteLn(f"  After Reverse: {Arr}")

  local SArr := ["banana", "apple", "cherry"]
  SArr.Sort()
  WriteLn(f"  Sorted strings: {SArr}")
  WriteLn("")

  // -------------------------------------------------------
  // 9. Dict methods: ContainsKey, Keys, Values, Remove
  // -------------------------------------------------------
  WriteLn("9. Dict methods:")

  local D := dict {"a": 1, "b": 2, "c": 3}
  WriteLn(f"  Dict: {D}")
  WriteLn(f"  ContainsKey 'b': {D.ContainsKey('b')}")
  WriteLn(f"  ContainsKey 'z': {D.ContainsKey('z')}")
  WriteLn(f"  Keys: {D.Keys()}")
  WriteLn(f"  Values: {D.Values()}")

  D.Remove("b")
  WriteLn(f"  After Remove 'b': {D}")
  WriteLn("")

  // -------------------------------------------------------
  // 10. String methods
  // -------------------------------------------------------
  WriteLn("10. String methods:")

  local S := "  Hello, World!  "
  WriteLn(f"  Original: '{S}'")
  WriteLn(f"  Trim: '{S.Trim()}'")
  WriteLn(f"  ToUpper: '{S.ToUpper()}'")
  WriteLn(f"  ToLower: '{S.ToLower()}'")

  local S2 := "hello world hello"
  WriteLn(f"  Replace 'hello' with 'hi': '{S2.Replace('hello', 'hi')}'")
  WriteLn(f"  Split on ' ': {S2.Split(' ')}")
  WriteLn(f"  StartsWith 'hello': {S2.StartsWith('hello')}")
  WriteLn(f"  EndsWith 'hello': {S2.EndsWith('hello')}")
  WriteLn(f"  Contains 'world': {S2.Contains('world')}")
  WriteLn(f"  Contains 'xyz': {S2.Contains('xyz')}")
  WriteLn("")

  // -------------------------------------------------------
  // 11. Str() generic conversion
  // -------------------------------------------------------
  WriteLn("11. Str() generic conversion:")

  WriteLn(f"  Str(42) = '{Str(42)}'")
  WriteLn(f"  Str(3.14) = '{Str(3.14)}'")
  WriteLn(f"  Str(True) = '{Str(True)}'")
  WriteLn(f"  Str('hello') = '{Str('hello')}'")
  WriteLn("")

  // -------------------------------------------------------
  // 12. Nested generics: Stack of Pairs
  // -------------------------------------------------------
  WriteLn("12. Stack of Pairs (nested generics):")

  var PairStack := create TStack<TPair>()
  var PA := create TPair<String, Integer>("x", 10)
  var PB := create TPair<String, Integer>("y", 20)
  PairStack.Push(PA)
  PairStack.Push(PB)
  WriteLn(f"  Stack count: {PairStack.GetCount()}")

  var PoppedPair := PairStack.Pop()
  if PoppedPair <> nil then
    WriteLn(f"  Popped: {PoppedPair.ToString()}")
  end

  PoppedPair := PairStack.Pop()
  if PoppedPair <> nil then
    WriteLn(f"  Popped: {PoppedPair.ToString()}")
  end

  free PairStack
  free PA
  free PB
  WriteLn("")

  WriteLn("=== All Generics Tests Complete ===")

end
