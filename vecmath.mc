// MimerCode Vector/Matrix Operators Test Suite
// Tests: V*V, M*M, division, negation, comparisons
// Copyright 2026 Components4Developers - Kim Bo Madsen
// Run with: MimerCodeRunner vecmath.mc

program VecMathTest

  WriteLn("=== Vector/Matrix Operator Tests ===")
  WriteLn("")

  // -------------------------------------------------------
  // 1. Vector element-wise multiplication: V * V
  // -------------------------------------------------------
  WriteLn("1. Vector * Vector (element-wise):")

  local V1 := vector([1.0, 2.0, 3.0])
  local V2 := vector([4.0, 5.0, 6.0])
  local V3 := V1 * V2
  WriteLn(f"  {V1} * {V2} = {V3}")
  // Expected: [4, 10, 18]
  WriteLn("")

  // -------------------------------------------------------
  // 2. Matrix multiplication: M * M
  // -------------------------------------------------------
  WriteLn("2. Matrix * Matrix (matrix multiplication):")

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

  local C := A * B
  WriteLn(f"  A(2x3) * B(3x2) = C(2x2)")
  WriteLn(f"  C[0,0] = {FloatToStr(C[0, 0])}")
  WriteLn(f"  C[0,1] = {FloatToStr(C[0, 1])}")
  WriteLn(f"  C[1,0] = {FloatToStr(C[1, 0])}")
  WriteLn(f"  C[1,1] = {FloatToStr(C[1, 1])}")
  // Expected: C = [[58, 64], [139, 154]]
  WriteLn("")

  // Verify: M * identity = M
  local I3 := identity(3)
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
  local M1I := M1 * I3
  WriteLn(f"  M * I = M? [0,0]={FloatToStr(M1I[0, 0])}, [1,1]={FloatToStr(M1I[1, 1])}, [2,2]={FloatToStr(M1I[2, 2])}")
  WriteLn("")

  // -------------------------------------------------------
  // 3. Division operators
  // -------------------------------------------------------
  WriteLn("3. Division operators:")

  // V / scalar
  local V4 := vector([10.0, 20.0, 30.0])
  local V5 := V4 / 5.0
  WriteLn(f"  [10,20,30] / 5 = {V5}")
  // Expected: [2, 4, 6]

  // scalar / V
  local V6 := 60.0 / vector([2.0, 3.0, 4.0])
  WriteLn(f"  60 / [2,3,4] = {V6}")
  // Expected: [30, 20, 15]

  // V / V (element-wise)
  local V7 := vector([10.0, 20.0, 30.0]) / vector([2.0, 4.0, 5.0])
  WriteLn(f"  [10,20,30] / [2,4,5] = {V7}")
  // Expected: [5, 5, 6]

  // M / scalar
  local M2 := ones(2, 2) * 10.0
  local M3 := M2 / 2.0
  WriteLn(f"  ones(2,2)*10 / 2 = sum {FloatToStr(sum(M3))}")
  // Expected: sum = 20 (each element 5.0)
  WriteLn("")

  // -------------------------------------------------------
  // 4. Unary negation
  // -------------------------------------------------------
  WriteLn("4. Unary negation:")

  local V8 := vector([1.0, -2.0, 3.0])
  local V9 := -V8
  WriteLn(f"  -{V8} = {V9}")
  // Expected: [-1, 2, -3]

  local M4 := identity(2)
  local M5 := -M4
  WriteLn(f"  -identity(2): [0,0]={FloatToStr(M5[0, 0])}, [1,1]={FloatToStr(M5[1, 1])}")
  // Expected: -1, -1
  WriteLn("")

  // -------------------------------------------------------
  // 5. Comparison operators
  // -------------------------------------------------------
  WriteLn("5. Comparison operators:")

  local VA := vector([1.0, 2.0, 3.0])
  local VB := vector([1.0, 2.0, 3.0])
  local VC := vector([1.0, 2.0, 4.0])

  WriteLn(f"  [1,2,3] = [1,2,3]: {VA = VB}")
  WriteLn(f"  [1,2,3] = [1,2,4]: {VA = VC}")
  WriteLn(f"  [1,2,3] <> [1,2,4]: {VA <> VC}")
  WriteLn(f"  [1,2,3] <> [1,2,3]: {VA <> VB}")

  // Approximate equality
  local VD := vector([1.0, 2.0, 3.0])
  local VE := vector([1.0000001, 2.0000001, 3.0000001])
  local VF := vector([1.01, 2.01, 3.01])
  WriteLn(f"  [1,2,3] ~= [1+eps,2+eps,3+eps]: {VD ~= VE}")
  WriteLn(f"  [1,2,3] ~= [1.01,2.01,3.01]: {VD ~= VF}")
  WriteLn("")

  // -------------------------------------------------------
  // 6. Combined operations (realistic use)
  // -------------------------------------------------------
  WriteLn("6. Combined operations:")

  // Normalize a vector manually using operators
  local V := vector([3.0, 4.0, 0.0])
  local N := norm(V)
  local VNorm := V / N
  WriteLn(f"  V = {V}")
  WriteLn(f"  norm = {FloatToStr(N)}")
  WriteLn(f"  V / norm = {VNorm}")
  WriteLn(f"  norm(V/norm) = {FloatToStr(norm(VNorm))}")

  // Weighted sum: w1*V1 + w2*V2
  local W1 := vector([1.0, 0.0, 0.0])
  local W2 := vector([0.0, 1.0, 0.0])
  local WSum := 0.7 * W1 + 0.3 * W2
  WriteLn(f"  0.7*[1,0,0] + 0.3*[0,1,0] = {WSum}")

  // Matrix: A * B - C
  local MA := identity(2)
  local MB := ones(2, 2) * 3.0
  local MC := ones(2, 2)
  local MR := MA * MB - MC
  WriteLn(f"  I*3ones - ones: [0,0]={FloatToStr(MR[0, 0])}, [0,1]={FloatToStr(MR[0, 1])}")
  // I * 3ones = 3ones, then 3ones - ones = 2ones, so [0,0]=2, [0,1]=2
  WriteLn("")

  // -------------------------------------------------------
  // 7. Scalar arithmetic still works
  // -------------------------------------------------------
  WriteLn("7. Scalar ops still work:")

  WriteLn(f"  V * 2 = {V1 * 2.0}")
  WriteLn(f"  3 * V = {3.0 * V1}")
  WriteLn(f"  V + V = {V1 + V2}")
  WriteLn(f"  V - V = {V2 - V1}")
  WriteLn("")

  WriteLn("=== All Vector/Matrix Tests Complete ===")

end
