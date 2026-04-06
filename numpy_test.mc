// MimerCode NumPy-style Features Test Suite
// Tests: @ operator, broadcasting, axis reductions, reshape, inv, det, solve
// Copyright 2026 Components4Developers - Kim Bo Madsen
// Run with: MimerCodeRunner numpy_test.mc

program NumpyTest

  WriteLn("=== NumPy-style Feature Tests ===")
  WriteLn("")

  // 1. @ operator
  WriteLn("1. @ operator:")
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
  local C := A @ B
  WriteLn(f"  M@M: [{FloatToStr(C[0,0])},{FloatToStr(C[0,1])};{FloatToStr(C[1,0])},{FloatToStr(C[1,1])}]")
  local V1 := vector([1.0, 2.0, 3.0])
  local V2 := vector([4.0, 5.0, 6.0])
  local D := V1 @ V2
  WriteLn(f"  V@V dot: {FloatToStr(D)}")
  local M := identity(3)
  M[0, 1] := 1.0
  local V := vector([1.0, 2.0, 3.0])
  local MV := M @ V
  WriteLn(f"  M@V: {MV}")
  WriteLn("")

  // 2. Scalar broadcasting
  WriteLn("2. Scalar broadcasting:")
  local V3 := vector([1.0, 2.0, 3.0])
  WriteLn(f"  10+V = {10.0 + V3}")
  WriteLn(f"  V+10 = {V3 + 10.0}")
  WriteLn(f"  100-V = {100.0 - V3}")
  WriteLn(f"  V-1 = {V3 - 1.0}")
  WriteLn("")

  // 3. Matrix + Vector broadcasting
  WriteLn("3. Row broadcasting:")
  local M2 := ones(3, 3)
  local VR := vector([10.0, 20.0, 30.0])
  local MR := M2 + VR
  WriteLn(f"  ones+V row0: {FloatToStr(MR[0,0])},{FloatToStr(MR[0,1])},{FloatToStr(MR[0,2])}")
  local MS := M2 * VR
  WriteLn(f"  ones*V row0: {FloatToStr(MS[0,0])},{FloatToStr(MS[0,1])},{FloatToStr(MS[0,2])}")
  WriteLn("")

  // 4. Axis reductions
  WriteLn("4. Axis reductions:")
  local M3: TMatrix
  M3 := matrix(3, 3, 0.0)
  M3[0,0] := 1.0
  M3[0,1] := 2.0
  M3[0,2] := 3.0
  M3[1,0] := 4.0
  M3[1,1] := 5.0
  M3[1,2] := 6.0
  M3[2,0] := 7.0
  M3[2,1] := 8.0
  M3[2,2] := 9.0
  WriteLn(f"  sum(M) = {FloatToStr(sum(M3))}")
  WriteLn(f"  sum(M,0) = {sum(M3, 0)}")
  WriteLn(f"  sum(M,1) = {sum(M3, 1)}")
  WriteLn(f"  mean(M) = {FloatToStr(mean(M3))}")
  WriteLn(f"  mean(M,0) = {mean(M3, 0)}")
  WriteLn(f"  mean(M,1) = {mean(M3, 1)}")
  WriteLn("")

  // 5. Reshape/flatten
  WriteLn("5. Reshape/flatten:")
  local V4 := vector([1.0, 2.0, 3.0, 4.0, 5.0, 6.0])
  local M4 := reshape(V4, 2, 3)
  WriteLn(f"  reshape: [{FloatToStr(M4[0,0])},{FloatToStr(M4[0,2])},{FloatToStr(M4[1,2])}]")
  local V5 := flatten(M4)
  WriteLn(f"  flatten: {V5}")
  WriteLn("")

  // 6. Row/col/slice
  WriteLn("6. Row/col/slice:")
  WriteLn(f"  row(M3,1) = {row(M3, 1)}")
  WriteLn(f"  col(M3,2) = {col(M3, 2)}")
  local S1 := slice(M3, 0, 2, 0, 2)
  WriteLn(f"  slice 2x2: [{FloatToStr(S1[0,0])},{FloatToStr(S1[0,1])};{FloatToStr(S1[1,0])},{FloatToStr(S1[1,1])}]")
  WriteLn("")

  // 7. Determinant
  WriteLn("7. Determinant:")
  WriteLn(f"  det(I2) = {FloatToStr(det(identity(2)))}")
  WriteLn(f"  det(I3) = {FloatToStr(det(identity(3)))}")
  local D2: TMatrix
  D2 := matrix(2, 2, 0.0)
  D2[0,0] := 1.0
  D2[0,1] := 2.0
  D2[1,0] := 3.0
  D2[1,1] := 4.0
  WriteLn(f"  det([[1,2],[3,4]]) = {FloatToStr(det(D2))}")
  WriteLn("")

  // 8. Inverse
  WriteLn("8. Inverse:")
  local InvD := inv(D2)
  WriteLn(f"  inv: [{FloatToStr(InvD[0,0])},{FloatToStr(InvD[0,1])};{FloatToStr(InvD[1,0])},{FloatToStr(InvD[1,1])}]")
  local Chk := D2 * InvD
  WriteLn(f"  A*inv(A): [{FloatToStr(Chk[0,0])},{FloatToStr(Chk[0,1])};{FloatToStr(Chk[1,0])},{FloatToStr(Chk[1,1])}]")
  WriteLn("")

  // 9. Solve
  WriteLn("9. Solve:")
  local SA: TMatrix
  SA := matrix(2, 2, 0.0)
  SA[0,0] := 2.0
  SA[0,1] := 1.0
  SA[1,0] := 5.0
  SA[1,1] := 3.0
  local SB := vector([4.0, 7.0])
  local SX := solve(SA, SB)
  WriteLn(f"  X = {SX}")
  local SC := SA @ SX
  WriteLn(f"  A@X = {SC}")
  WriteLn("")

  // 10. Linear regression
  WriteLn("10. Linear regression:")
  local XD: TMatrix
  XD := matrix(5, 2, 0.0)
  XD[0,0] := 1.0
  XD[0,1] := 1.0
  XD[1,0] := 1.0
  XD[1,1] := 2.0
  XD[2,0] := 1.0
  XD[2,1] := 3.0
  XD[3,0] := 1.0
  XD[3,1] := 4.0
  XD[4,0] := 1.0
  XD[4,1] := 5.0
  local YD := vector([2.0, 4.0, 5.0, 4.0, 5.0])
  local XT := transpose(XD)
  local Beta := inv(XT @ XD) @ (XT @ YD)
  WriteLn(f"  Beta = {Beta}")
  WriteLn("")

  WriteLn("=== All Tests Complete ===")

end
