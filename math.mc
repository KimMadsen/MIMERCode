// MimerCode Sample - Math and Number Theory
// Copyright 2026 Components4Developers - Kim Bo Madsen
// Run with: MimerCodeRunner math.mc

program MathDemo

  // --- Greatest Common Divisor (Euclid) ---
  func GCD(A: Integer, B: Integer) -> Integer
    while B <> 0 do
      local Temp: Integer
      Temp := B
      B := A mod B
      A := Temp
    end
    return A
  end

  // --- Least Common Multiple ---
  func LCM(A: Integer, B: Integer) -> Integer
    return (A div GCD(A, B)) * B
  end

  // --- Prime check ---
  func IsPrime(N: Integer) -> Boolean
    if N < 2 then
      return False
    end
    if N < 4 then
      return True
    end
    if (N mod 2) = 0 then
      return False
    end
    local I: Integer = 3
    while I * I <= N do
      if (N mod I) = 0 then
        return False
      end
      I += 2
    end
    return True
  end

  // --- Sieve of Eratosthenes ---
  func Primes(Limit: Integer) -> TArray<Integer>
    local Sieve: TArray<Boolean>
    SetLength(Sieve, Limit + 1)
    // Initialize all to True
    for I := 0 to Limit do
      Sieve[I] := True
    end
    Sieve[0] := False
    if Limit >= 1 then
      Sieve[1] := False
    end

    local P: Integer = 2
    while P * P <= Limit do
      if Sieve[P] then
        local J: Integer
        J := P * P
        while J <= Limit do
          Sieve[J] := False
          J += P
        end
      end
      P += 1
    end

    // Collect primes
    local Result: TArray<Integer>
    Result := []
    for I := 2 to Limit do
      if Sieve[I] then
        SetLength(Result, Length(Result) + 1)
        Result[Length(Result) - 1] := I
      end
    end
    return Result
  end

  // --- Power (integer exponentiation) ---
  func IntPow(Base: Integer, Exp: Integer) -> Integer
    local Result: Integer = 1
    for I := 1 to Exp do
      Result *= Base
    end
    return Result
  end

  // --- Collatz sequence length ---
  func CollatzLength(N: Integer) -> Integer
    local Steps: Integer = 0
    while N <> 1 do
      if (N mod 2) = 0 then
        N := N div 2
      else
        N := 3 * N + 1
      end
      Steps += 1
    end
    return Steps
  end

  // --- Demos ---
  WriteLn('=== Math and Number Theory ===')
  WriteLn('')

  WriteLn('GCD and LCM:')
  WriteLn(f'  GCD(48, 18) = {GCD(48, 18)}')
  WriteLn(f'  GCD(100, 75) = {GCD(100, 75)}')
  WriteLn(f'  LCM(12, 8) = {LCM(12, 8)}')
  WriteLn(f'  LCM(15, 20) = {LCM(15, 20)}')
  WriteLn('')

  WriteLn('Prime check:')
  for N := 2 to 20 do
    if IsPrime(N) then
      WriteLn(f'  {N} is prime')
    end
  end
  WriteLn('')

  WriteLn('Sieve of Eratosthenes (primes up to 50):')
  local PrimeList: TArray<Integer>
  PrimeList := Primes(50)
  local PrimeLine: String = ''
  for I := 0 to Length(PrimeList) - 1 do
    if I > 0 then
      PrimeLine += ', '
    end
    PrimeLine += IntToStr(PrimeList[I])
  end
  WriteLn(f'  {PrimeLine}')
  WriteLn('')

  WriteLn('Powers of 2:')
  for I := 0 to 10 do
    WriteLn(f'  2^{I} = {IntPow(2, I)}')
  end
  WriteLn('')

  WriteLn('Collatz sequence lengths:')
  for N := 1 to 15 do
    WriteLn(f'  Collatz({N}) takes {CollatzLength(N)} steps')
  end

end
