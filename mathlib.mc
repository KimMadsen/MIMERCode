// MimerCode Sample Library - Math Utilities
// Copyright 2026 Components4Developers - Kim Bo Madsen

library MathLib

  func Factorial(N: Integer) -> Integer
    if N <= 1 then
      return 1
    end
    return N * Factorial(N - 1)
  end

  func Fibonacci(N: Integer) -> Integer
    if N <= 1 then
      return N
    end
    return Fibonacci(N - 1) + Fibonacci(N - 2)
  end

  func IsPrime(N: Integer) -> Boolean
    if N < 2 then
      return false
    end
    if N < 4 then
      return true
    end
    if (N mod 2) = 0 then
      return false
    end
    local I: Integer = 3
    while I * I <= N do
      if (N mod I) = 0 then
        return false
      end
      I += 2
    end
    return true
  end

end
