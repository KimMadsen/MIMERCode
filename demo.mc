// MimerCode Demo - Core Language Features
// Copyright 2026 Components4Developers - Kim Bo Madsen
// Run with: MimerCodeRunner demo.mc

program Demo

  // --- Constants and Variables ---
  const VERSION = 1
  const APP_NAME = 'MimerCode Demo'

  WriteLn(f'{APP_NAME} v{VERSION}')
  WriteLn('========================')
  WriteLn('')

  // --- Arithmetic and String Interpolation ---
  local A: Integer = 17
  local B: Integer = 5
  WriteLn(f'{A} + {B} = {A + B}')
  WriteLn(f'{A} * {B} = {A * B}')
  WriteLn(f'{A} div {B} = {A div B}')
  WriteLn(f'{A} mod {B} = {A mod B}')
  WriteLn('')

  // --- Functions ---
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
    local A: Integer = 0
    local B: Integer = 1
    local Temp: Integer
    for I := 2 to N do
      Temp := B
      B := A + B
      A := Temp
    end
    return B
  end

  WriteLn('Factorials:')
  for I := 1 to 8 do
    WriteLn(f'  {I}! = {Factorial(I)}')
  end
  WriteLn('')

  WriteLn('Fibonacci sequence:')
  local FibLine: String = ''
  for I := 0 to 12 do
    if I > 0 then
      FibLine += ', '
    end
    FibLine += IntToStr(Fibonacci(I))
  end
  WriteLn(f'  {FibLine}')
  WriteLn('')

  // --- Arrays ---
  local Names: TArray<String>
  Names := ['Alice', 'Bob', 'Charlie', 'Diana', 'Eve']

  WriteLn(f'Team ({Length(Names)} members):')
  for Name in Names do
    WriteLn(f'  - {Name}')
  end
  WriteLn('')

  // --- Dictionaries ---
  local Scores: TDictionary<String, Integer>
  Scores := dict{
    'Alice': 95,
    'Bob': 87,
    'Charlie': 92,
    'Diana': 88,
    'Eve': 96
  }

  WriteLn('Scores:')
  for Pair in Scores do
    WriteLn(f'  {Pair.Key}: {Pair.Value}')
  end
  WriteLn('')

  // --- FizzBuzz ---
  WriteLn('FizzBuzz (1-20):')
  local Line: String = ''
  for I := 1 to 20 do
    if I > 1 then
      Line += ', '
    end
    if (I mod 15) = 0 then
      Line += 'FizzBuzz'
    elif (I mod 3) = 0 then
      Line += 'Fizz'
    elif (I mod 5) = 0 then
      Line += 'Buzz'
    else
      Line += IntToStr(I)
    end
  end
  WriteLn(f'  {Line}')
  WriteLn('')

  // --- Lambdas ---
  local Square: TFunc<Integer, Integer>
  Square := lambda(const X: Integer) -> Integer
    return X * X
  end

  WriteLn('Squares:')
  local SqLine: String = ''
  for I := 1 to 10 do
    if I > 1 then
      SqLine += ', '
    end
    SqLine += IntToStr(Square(I))
  end
  WriteLn(f'  {SqLine}')
  WriteLn('')

  // --- Enumerations ---
  enum TDay
    Monday
    Tuesday
    Wednesday
    Thursday
    Friday
    Saturday
    Sunday
  end

  local Today: TDay
  Today := Wednesday
  WriteLn(f'Today is {Today}')
  WriteLn('')

  // --- Error Handling ---
  WriteLn('Error handling:')
  try
    local X: Integer = 0
    if X = 0 then
      raise Exception.Create('Division by zero avoided!')
    end
  except on E: Exception do
    WriteLn(f'  Caught: {E}')
  end

  // --- Nil Coalescing ---
  local Greeting: String
  Greeting := '' ?? 'Hello, World!'
  WriteLn(f'  Greeting: {Greeting}')
  WriteLn('')

  // --- Nested Functions with Closure ---
  func MakeGreeter(const Prefix: String) -> TFunc<String, String>
    return lambda(const Name: String) -> String
      return Prefix + ', ' + Name + '!'
    end
  end

  local Hi: TFunc<String, String>
  Hi := MakeGreeter('Hello')
  WriteLn(Hi('World'))
  WriteLn(Hi('MimerCode'))

  WriteLn('')
  WriteLn('Demo complete.')
end
