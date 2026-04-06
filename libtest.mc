// MimerCode Sample - Library Usage Demo
// Copyright 2026 Components4Developers - Kim Bo Madsen
// Run with: MimerCodeRunner libtest.mc

program LibTest

  uses MathLib

  WriteLn("=== Library Test ===")
  WriteLn("")

  WriteLn("Factorials:")
  for I := 1 to 10 do
    WriteLn(f"  {I}! = {Factorial(I)}")
  end
  WriteLn("")

  WriteLn("Fibonacci:")
  for I := 0 to 10 do
    WriteLn(f"  Fib({I}) = {Fibonacci(I)}")
  end
  WriteLn("")

  WriteLn("Primes up to 30:")
  local Line: String = ""
  for N := 2 to 30 do
    if IsPrime(N) then
      if Length(Line) > 0 then
        Line += ", "
      end
      Line += IntToStr(N)
    end
  end
  WriteLn(f"  {Line}")

end
