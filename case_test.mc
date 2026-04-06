// MimerCode Case Statement + Approximate Equality Test Suite
// Copyright 2026 Components4Developers - Kim Bo Madsen
// Run with: MimerCodeRunner case_test.mc

program CaseTests

  WriteLn('=== MimerCode Case Statement Tests ===')
  WriteLn('')

  // --- 1. Integer case (classic) ---
  WriteLn('1. Integer case:')
  local LVal: Integer = 5
  case LVal of
    0:
      WriteLn('  zero')
    1, 2, 3:
      WriteLn('  small')
    4..10:
      WriteLn('  medium')
    else
      WriteLn('  large')
  end
  WriteLn('')

  // --- 2. String case ---
  WriteLn('2. String case:')
  local LCmd: String = 'help'
  case LCmd of
    'help', '?':
      WriteLn('  Show help')
    'quit', 'exit':
      WriteLn('  Goodbye')
    'version':
      WriteLn('  v1.0')
    else
      WriteLn(f'  Unknown: {LCmd}')
  end

  local LCmd2: String = 'exit'
  case LCmd2 of
    'help', '?':
      WriteLn('  Show help')
    'quit', 'exit':
      WriteLn('  Goodbye')
    else
      WriteLn(f'  Unknown: {LCmd2}')
  end
  WriteLn('')

  // --- 3. Boolean case ---
  WriteLn('3. Boolean case:')
  local LFlag: Boolean = True
  case LFlag of
    True:
      WriteLn('  Flag is on')
    False:
      WriteLn('  Flag is off')
  end
  WriteLn('')

  // --- 4. Float case with default epsilon ---
  WriteLn('4. Float case (default epsilon 1e-6):')
  local LAngle: Double = 90.0000001
  case LAngle of
    0.0:
      WriteLn('  zero')
    90.0:
      WriteLn('  right angle')
    180.0:
      WriteLn('  straight')
    else
      WriteLn(f'  other: {LAngle}')
  end
  WriteLn('')

  // --- 5. Float case with explicit epsilon ---
  WriteLn('5. Float case (epsilon 0.1):')
  local LSensor: Double = 2.55
  case LSensor of epsilon 0.1
    1.0:
      WriteLn('  nominal')
    2.5:
      WriteLn('  warning')
    5.0:
      WriteLn('  critical')
    else
      WriteLn(f'  unknown: {LSensor}')
  end
  WriteLn('')

  // --- 6. Float range case ---
  WriteLn('6. Float range case:')
  local LTemp: Double = 37.2
  case LTemp of epsilon 0.5
    35.0..36.5:
      WriteLn('  hypothermia')
    36.5..37.5:
      WriteLn('  normal')
    37.5..38.5:
      WriteLn('  low fever')
    38.5..42.0:
      WriteLn('  high fever')
    else
      WriteLn(f'  extreme: {LTemp}')
  end
  WriteLn('')

  // --- 7. Tuple case ---
  WriteLn('7. Tuple case:')
  local LPoint := (1, 0)
  case LPoint of
    (0, 0):
      WriteLn('  origin')
    (1, 0):
      WriteLn('  unit X')
    (0, 1):
      WriteLn('  unit Y')
    else
      WriteLn(f'  other: {LPoint}')
  end
  WriteLn('')

  // --- 8. Approximate equality operator ~= ---
  WriteLn('8. Approximate equality (~=):')
  local X: Double = 0.1 + 0.2
  WriteLn(f'  0.1 + 0.2 = {X}')
  if X = 0.3 then
    WriteLn('  X = 0.3 (exact) -> True')
  else
    WriteLn('  X = 0.3 (exact) -> False (expected!)')
  end
  if X ~= 0.3 then
    WriteLn('  X ~= 0.3 (approx) -> True')
  else
    WriteLn('  X ~= 0.3 (approx) -> False')
  end
  WriteLn('')

  // --- 9. Approximate inequality ~<> ---
  WriteLn('9. Approximate inequality (~<>):')
  local A: Double = 1.0
  local B: Double = 1.0000001
  local C: Double = 1.5
  WriteLn(f'  1.0 ~<> 1.0000001 -> {A ~<> B}')
  WriteLn(f'  1.0 ~<> 1.5 -> {A ~<> C}')
  WriteLn('')

  // --- 10. near() function ---
  WriteLn('10. near() function:')
  WriteLn(f'  near(1.0, 1.0000001) -> {near(1.0, 1.0000001)}')
  WriteLn(f'  near(1.0, 1.5) -> {near(1.0, 1.5)}')
  WriteLn(f'  near(1.0, 1.5, 1.0) -> {near(1.0, 1.5, 1.0)}')
  WriteLn(f'  near(3.14, 3.14159, 0.01) -> {near(3.14, 3.14159, 0.01)}')
  WriteLn(f'  near(3.14, 3.14159, 0.001) -> {near(3.14, 3.14159, 0.001)}')
  WriteLn('')

  // --- 11. Case with multiple statements in branch ---
  WriteLn('11. Multi-statement branches:')
  local LGrade: String = 'B'
  case LGrade of
    'A':
      WriteLn('  Excellent!')
      WriteLn('  Top of class')
    'B':
      WriteLn('  Good job!')
      WriteLn('  Above average')
    'C':
      WriteLn('  Acceptable')
    else
      WriteLn('  Needs improvement')
  end
  WriteLn('')

  // --- 12. Enum case ---
  WriteLn('12. Enum case:')
  enum TColor
    Red
    Green
    Blue
  end

  local LColor: TColor = Blue
  case LColor of
    Red:
      WriteLn('  Stop')
    Green:
      WriteLn('  Go')
    Blue:
      WriteLn('  Sky')
  end
  WriteLn('')

  WriteLn('=== All Case Tests Complete ===')

end
