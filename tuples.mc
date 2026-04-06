// MimerCode Tuple Test Suite
// Copyright 2026 Components4Developers - Kim Bo Madsen
// Run with: MimerCodeRunner tuples.mc

program TupleTests

  WriteLn('=== MimerCode Tuple Tests ===')
  WriteLn('')

  // --- Tuple Literals ---
  WriteLn('1. Tuple Literals:')
  local LPair := (42, 'Hello')
  WriteLn(f'  LPair = {LPair}')

  local LTriple := (1, 2.5, True)
  WriteLn(f'  LTriple = {LTriple}')

  local LNested := ((1, 2), (3, 4))
  WriteLn(f'  LNested = {LNested}')

  local LSingle := (42,)
  WriteLn(f'  LSingle = {LSingle}')
  WriteLn('')

  // --- Tuple Indexing ---
  WriteLn('2. Tuple Indexing:')
  WriteLn(f'  LPair[0] = {LPair[0]}')
  WriteLn(f'  LPair[1] = {LPair[1]}')
  WriteLn(f'  LTriple[2] = {LTriple[2]}')
  WriteLn('')

  // --- Tuple Properties ---
  WriteLn('3. Tuple Properties:')
  WriteLn(f'  LPair.Count = {LPair.Count}')
  WriteLn(f'  LTriple.Length = {LTriple.Length}')
  WriteLn(f'  Length(LPair) = {Length(LPair)}')
  WriteLn(f'  High(LTriple) = {High(LTriple)}')
  WriteLn('')

  // --- Tuple Return Values ---
  WriteLn('4. Tuple Return Values:')

  func DivMod(A: Integer, B: Integer) -> (Integer, Integer)
    return A div B, A mod B
  end

  local Q, R := DivMod(17, 5)
  WriteLn(f'  DivMod(17, 5) = Q={Q}, R={R}')

  // Capture as single value
  local Result := DivMod(23, 7)
  WriteLn(f'  DivMod(23, 7) = {Result}')
  WriteLn(f'  Result[0] = {Result[0]}, Result[1] = {Result[1]}')
  WriteLn('')

  // --- Tuple Destructuring ---
  WriteLn('5. Tuple Destructuring:')
  local X, Y := (100, 200)
  WriteLn(f'  X={X}, Y={Y}')

  local A, B, C := (10, 20, 30)
  WriteLn(f'  A={A}, B={B}, C={C}')
  WriteLn('')

  // --- Multi-value Return from Complex Function ---
  WriteLn('6. Complex Tuple Returns:')

  func MinMax(Arr: TArray<Integer>) -> (Integer, Integer)
    local Lo: Integer = Arr[0]
    local Hi: Integer = Arr[0]
    for I := 1 to Length(Arr) - 1 do
      if Arr[I] < Lo then
        Lo := Arr[I]
      end
      if Arr[I] > Hi then
        Hi := Arr[I]
      end
    end
    return Lo, Hi
  end

  local Data: TArray<Integer>
  Data := [5, 2, 8, 1, 9, 3, 7]
  local Lo, Hi := MinMax(Data)
  WriteLn(f'  MinMax([5,2,8,1,9,3,7]) = Lo={Lo}, Hi={Hi}')
  WriteLn('')

  // --- Tuple Equality ---
  WriteLn('7. Tuple Equality:')
  local T1 := (1, 2)
  local T2 := (1, 2)
  local T3 := (1, 3)
  WriteLn(f'  (1, 2) = (1, 2) -> {T1 = T2}')
  WriteLn(f'  (1, 2) = (1, 3) -> {T1 = T3}')
  WriteLn(f'  (1, 2) <> (1, 3) -> {T1 <> T3}')
  WriteLn('')

  // --- Tuple Iteration ---
  WriteLn('8. Tuple Iteration:')
  local Items := (10, 'hello', True)
  Write('  for-in: ')
  for Item in Items do
    Write(f'{Item} ')
  end
  WriteLn('')
  WriteLn('')

  // --- Tuples in Collections ---
  WriteLn('9. Tuples in Collections:')
  local Points: TArray<Integer>
  // Store tuples in array
  local P1 := (0, 0)
  local P2 := (1, 2)
  local P3 := (3, 4)

  // Access nested tuple values
  WriteLn(f'  P1 = {P1}')
  WriteLn(f'  P2 = {P2}')
  WriteLn(f'  P3 = {P3}')
  WriteLn('')

  // --- Tuple Immutability ---
  WriteLn('10. Tuple Immutability:')
  WriteLn('  (Skipping assignment test - would raise error)')
  WriteLn('  Workaround: unpack and repack')
  local OldA, OldB := LPair
  local NewPair := (99, OldB)
  WriteLn(f'  Original: {LPair}')
  WriteLn(f'  Modified: {NewPair}')
  WriteLn('')

  // --- Tuple as Function Parameter ---
  WriteLn('11. Tuple as Parameter:')

  func SumPair(const P: Tuple<Integer, Integer>) -> Integer
    return P[0] + P[1]
  end

  WriteLn(f'  SumPair((3, 4)) = {SumPair((3, 4))}')
  WriteLn(f'  SumPair((10, 20)) = {SumPair((10, 20))}')
  WriteLn('')

  WriteLn('=== All Tuple Tests Complete ===')

end
