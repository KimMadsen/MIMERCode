// MimerCode Sample - Linear Algebra
// Copyright 2026 Components4Developers - Kim Bo Madsen
// Run with: MimerCodeRunner linalg.mc

program LinAlg

  WriteLn('=== Linear Algebra Demo ===')
  WriteLn('')

  // --- Vector Creation ---
  WriteLn('Vector creation:')
  local V1: TVector
  V1 := vector([1.0, 2.0, 3.0])
  WriteLn(f'  V1 = {V1}')

  local V2: TVector
  V2 := vector([4.0, 5.0, 6.0])
  WriteLn(f'  V2 = {V2}')

  local V3: TVector
  V3 := zeros(5)
  WriteLn(f'  zeros(5) = {V3}')

  local V4: TVector
  V4 := ones(4)
  WriteLn(f'  ones(4) = {V4}')

  local V5: TVector
  V5 := linspace(0.0, 1.0, 5)
  WriteLn(f'  linspace(0, 1, 5) = {V5}')
  WriteLn('')

  // --- Vector Arithmetic ---
  WriteLn('Vector arithmetic:')
  WriteLn(f'  V1 + V2 = {vadd(V1, V2)}')
  WriteLn(f'  V1 - V2 = {vsub(V1, V2)}')
  WriteLn(f'  V1 .* V2 = {vmul(V1, V2)}')
  WriteLn(f'  V1 * 3 = {vscale(V1, 3.0)}')
  WriteLn('')

  // --- Vector Reductions ---
  WriteLn('Vector reductions:')
  WriteLn(f'  dot(V1, V2) = {FloatToStr(dot(V1, V2))}')
  WriteLn(f'  norm(V1) = {FloatToStr(norm(V1))}')
  WriteLn(f'  vsum(V1) = {FloatToStr(vsum(V1))}')
  WriteLn(f'  vmin(V1) = {FloatToStr(vmin(V1))}')
  WriteLn(f'  vmax(V2) = {FloatToStr(vmax(V2))}')
  WriteLn('')

  // --- Cross Product ---
  WriteLn('Cross product:')
  local VX: TVector
  VX := vector([1.0, 0.0, 0.0])
  local VY: TVector
  VY := vector([0.0, 1.0, 0.0])
  WriteLn(f'  X cross Y = {cross(VX, VY)}')
  WriteLn('')

  // --- Normalize ---
  WriteLn('Normalize:')
  local VN: TVector
  VN := normalize(V1)
  WriteLn(f'  normalize(V1) = {VN}')
  WriteLn(f'  norm(normalized) = {FloatToStr(norm(VN))}')
  WriteLn('')

  // --- Matrix Creation ---
  WriteLn('Matrix creation:')
  local M1: TMatrix
  M1 := matrix(3, 3, 0.0)
  M1[0, 0] := 1.0
  M1[0, 1] := 2.0
  M1[0, 2] := 3.0
  M1[1, 0] := 4.0
  M1[1, 1] := 5.0
  M1[1, 2] := 6.0
  M1[2, 0] := 7.0
  M1[2, 1] := 8.0
  M1[2, 2] := 9.0
  WriteLn(f'  M1 = {M1}')
  WriteLn(f'  M1.Rows = {IntToStr(M1.Rows)}')
  WriteLn(f'  M1.Cols = {IntToStr(M1.Cols)}')
  WriteLn(f'  M1[1, 2] = {FloatToStr(M1[1, 2])}')
  WriteLn('')

  // --- Identity Matrix ---
  WriteLn('Identity matrix:')
  local I3: TMatrix
  I3 := identity(3)
  WriteLn(f'  I3 = {I3}')
  WriteLn(f'  trace(I3) = {FloatToStr(trace(I3))}')
  WriteLn('')

  // --- Matrix Multiplication ---
  WriteLn('Matrix multiplication:')
  local A: TMatrix
  A := matrix(2, 3, 0.0)
  A[0, 0] := 1.0
  A[0, 1] := 2.0
  A[0, 2] := 3.0
  A[1, 0] := 4.0
  A[1, 1] := 5.0
  A[1, 2] := 6.0

  local B: TMatrix
  B := matrix(3, 2, 0.0)
  B[0, 0] := 7.0
  B[0, 1] := 8.0
  B[1, 0] := 9.0
  B[1, 1] := 10.0
  B[2, 0] := 11.0
  B[2, 1] := 12.0

  local C: TMatrix
  C := mmul(A, B)
  WriteLn(f'  A(2x3) * B(3x2) = C(2x2)')
  WriteLn(f'  C[0,0] = {FloatToStr(C[0, 0])}')
  WriteLn(f'  C[0,1] = {FloatToStr(C[0, 1])}')
  WriteLn(f'  C[1,0] = {FloatToStr(C[1, 0])}')
  WriteLn(f'  C[1,1] = {FloatToStr(C[1, 1])}')
  WriteLn('')

  // --- Transpose ---
  WriteLn('Transpose:')
  local AT: TMatrix
  AT := transpose(A)
  WriteLn(f'  A is {IntToStr(A.Rows)}x{IntToStr(A.Cols)}')
  WriteLn(f'  transpose(A) is {IntToStr(AT.Rows)}x{IntToStr(AT.Cols)}')
  WriteLn('')

  // --- Diagonal Matrix ---
  WriteLn('Diagonal matrix:')
  local D: TMatrix
  D := diag([2.0, 4.0, 6.0])
  WriteLn(f'  diag([2,4,6]) = {D}')
  WriteLn(f'  trace = {FloatToStr(trace(D))}')
  WriteLn('')

  // --- Array Multiplication ---
  WriteLn('Array multiplication:')
  local Arr: TArray<Integer>
  Arr := [1, 2, 3] * 3
  WriteLn(f'  [1,2,3] * 3 = {Arr}')

  local Zeros: TArray<Boolean>
  Zeros := repeat(False, 5)
  WriteLn(f'  repeat(False, 5) = {Zeros}')

  local Filled: TArray<Integer>
  Filled := fill(4, 42)
  WriteLn(f'  fill(4, 42) = {Filled}')
  WriteLn('')

  // --- Matrix element-wise with operators ---
  WriteLn('Element-wise matrix ops:')
  local M2: TMatrix
  M2 := ones(2, 2)
  local M3: TMatrix
  M3 := M2 + M2
  WriteLn(f'  ones(2,2) + ones(2,2): sum = {FloatToStr(sum(M3))}')
  local M4: TMatrix
  M4 := M2 * 5.0
  WriteLn(f'  ones(2,2) * 5: sum = {FloatToStr(sum(M4))}')
  WriteLn('')

  // --- Statistics ---
  WriteLn('Statistics:')
  local Data: TVector
  Data := vector([10.0, 20.0, 30.0, 40.0, 50.0])
  WriteLn(f'  Data = {Data}')
  WriteLn(f'  sum = {FloatToStr(sum(Data))}')
  WriteLn(f'  mean = {FloatToStr(mean(Data))}')
  WriteLn(f'  min = {FloatToStr(vmin(Data))}')
  WriteLn(f'  max = {FloatToStr(vmax(Data))}')
  WriteLn('')

  WriteLn('Demo complete.')
end
