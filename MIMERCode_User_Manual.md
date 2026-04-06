# MIMERCode User Manual

**Version 1.0**

Copyright 2026 Components4Developers - Kim Bo Madsen
Proprietary commercial license.

---

## About This Manual

MIMERCode is a programming language designed to be readable by humans and writable by machines. Whether you are a first-time programmer, an experienced Delphi developer, or an AI engineer building LLM-powered applications, MIMERCode meets you where you are.

This manual is organized in layers. Start from the beginning if you are new to programming. Skip to later chapters if you already know your way around code.

### Who Is This For?

**Beginners** -- Chapters 1 through 5 teach MIMERCode from scratch. No prior programming experience required.

**Delphi Developers** -- Chapter 22 maps MIMERCode to Delphi patterns you already know and explains what changed and why.

**Python Developers and LLM Engineers** -- Chapter 23 shows how MIMERCode relates to Python, why LLMs generate correct MIMERCode naturally, and how contracts and pipelines make AI-generated code safe.

---

## Table of Contents

### Part I: Getting Started
1. Your First Program
2. Variables, Types, and Expressions
3. Making Decisions and Repeating Things
4. Functions
5. Collections: Arrays and Dictionaries

### Part II: Working with Text and Data
6. Strings and Text Processing
7. Pattern Matching with Regex
8. Tuples: Returning Multiple Values
9. Error Handling

### Part III: Organizing Code
10. Object-Oriented Programming
11. Lambdas and Higher-Order Functions
12. Libraries and Modules

### Part IV: Data Safety with Contracts
13. Contracts: Data You Can Trust

### Part V: Composable Workflows
14. Pipelines: Building Reliable Workflows

### Part VI: Channels and I/O
15. Channels: One Pattern for All I/O
16. HTTP Servers and Authentication
17. Templates
18. Configuration and Logging

### Part VII: Mathematics and Science
19. Math, Statistics, and Linear Algebra

### Part VIII: Building GUIs
20. Views: Declarative User Interfaces

### Part IX: For Experienced Developers
21. For Delphi Developers
22. For Python Developers and LLM Engineers

### Appendices
- A: Complete Function Reference
- B: Operator Reference
- C: Keyword Reference

---

# Part I: Getting Started

---

## Chapter 1: Your First Program

### What Is MIMERCode?

MIMERCode is a programming language built on three principles:

1. **Readable by everyone.** The syntax uses plain English keywords: if, then, else, end, for, while, func, return. No cryptic symbols, no invisible whitespace rules, no semicolons. A business analyst can read a MIMERCode program and understand what it does.

2. **Writable by AI.** Large Language Models (LLMs like ChatGPT, Claude, Gemini) can generate correct MIMERCode on the first try because the syntax matches what they already know from Python, JavaScript, and dozens of other languages. Every design decision in MIMERCode was made to minimize the chance of an LLM producing code that does not work.

3. **Self-contained and secure.** A MIMERCode program carries its own data validation, its own security rules, and its own error handling. Contracts ensure that data entering your program is always the right shape. Channels sandbox all I/O. There is no way for code to quietly access files, networks, or databases without explicit permission.

### The Console Runner

MIMERCode programs are text files with the .mc extension. You run them from the command line:

    MIMERCodeRunner hello.mc

The console runner executes your program, prints output to the terminal, and exits. Everything in the first half of this manual uses it.

### Hello World

Save this as hello.mc:

    program Hello
      WriteLn("Hello, World!")
    end

Run it:

    MIMERCodeRunner hello.mc

Output:

    Hello, World!

That is a complete program. `program` names it, `WriteLn` prints a line, and `end` closes the block. No imports, no boilerplate, no configuration files.

### A Bigger Example

    program Greeting
      local Name := "World"
      WriteLn(f"Hello, {Name}!")

      local Age := 25
      if Age >= 18 then
        WriteLn("You are an adult.")
      else
        WriteLn("You are a minor.")
      end

      for I := 1 to 5 do
        WriteLn(f"Count: {I}")
      end
    end

Output:

    Hello, World!
    You are an adult.
    Count: 1
    Count: 2
    Count: 3
    Count: 4
    Count: 5

Notice: variables are declared with `local` and assigned with `:=`. F-strings embed expressions inside curly braces. Every if, for, and while block ends with `end`. No semicolons anywhere.

### Comments

Single-line comments start with //:

    // This is a comment
    local X := 42   // inline comment

There are no block comments. This is intentional -- block comments cause nesting problems for both humans and AI code generators.

---

## Chapter 2: Variables, Types, and Expressions

### Declaring Variables

Use `local` (or `var` -- they are identical) to declare a variable:

    local Count := 0
    local Name := "Alice"
    local Pi := 3.14159
    local Active := true

MIMERCode figures out the type from the value. You can also state it explicitly:

    local Count: Integer := 0
    local Name: String := "Alice"

### Types

| Type | Example | Description |
|---|---|---|
| Integer | 42 | Whole numbers |
| Double | 3.14 | Decimal numbers |
| String | "hello" | Text |
| Boolean | true, false | Yes/no values |

### Arithmetic

    local A := 10
    local B := 3
    WriteLn(A + B)     // 13
    WriteLn(A - B)     // 7
    WriteLn(A * B)     // 30
    WriteLn(A / B)     // 3.333...  (float division)
    WriteLn(A div B)   // 3         (integer division)
    WriteLn(A mod B)   // 1         (remainder)

### Shorthand Assignment

    local X := 10
    X += 5     // X is now 15
    X -= 3     // X is now 12
    X *= 2     // X is now 24

### Comparison

    WriteLn(10 > 5)      // true
    WriteLn(10 = 10)     // true  (single = for comparison)
    WriteLn(10 <> 5)     // true  (<> means "not equal")
    WriteLn(10 <= 10)    // true

Note: MIMERCode uses `=` for comparison and `:=` for assignment. This prevents the classic "assignment in a condition" bug.

### Logical Operators

    if Age >= 18 and HasLicense then
      WriteLn("Can drive")
    end

    if IsWeekend or IsHoliday then
      WriteLn("Day off")
    end

    if not Active then
      WriteLn("Inactive")
    end

The `and` and `or` operators use short-circuit evaluation.

### Nil and Nil Coalescing

`nil` represents "no value". The `??` operator provides a fallback:

    local Name := UserInput ?? "Anonymous"
    // If UserInput is nil, Name becomes "Anonymous"

### Type Conversion

    local N := int("42")       // string to integer
    local F := float("3.14")   // string to float
    local S := Str(42)         // any value to string
    local T := type(42)        // "Integer" (type name)

### Constants

    const MAX_RETRIES = 3
    const APP_NAME = "MyApp"

---

## Chapter 3: Making Decisions and Repeating Things

### If / Elif / Else

    if Temperature > 30 then
      WriteLn("Hot")
    elif Temperature > 20 then
      WriteLn("Warm")
    elif Temperature > 10 then
      WriteLn("Cool")
    else
      WriteLn("Cold")
    end

Every if block closes with `end`. No ambiguity about where the block ends.

### Conditional Expressions (Ternary)

When you need a value based on a condition:

    local Status := if Score >= 60 then "pass" else "fail" end
    local Max := if A > B then A else B end

### While Loops

    local Count := 10
    while Count > 0
      WriteLn(f"Countdown: {Count}")
      Count -= 1
    end

The `do` keyword after the condition is optional.

### For Loops

    // Counted
    for I := 1 to 10 do
      WriteLn(I)
    end

    // Iterating a collection
    local Names := ["Alice", "Bob", "Charlie"]
    for Name in Names do
      WriteLn(f"Hello, {Name}!")
    end

    // With index
    for I, Name in Names do
      WriteLn(f"{I}: {Name}")
    end

### Range-Based Loops

    for I in range(5) do        // 0, 1, 2, 3, 4
      WriteLn(I)
    end

    for I in range(2, 8) do     // 2, 3, 4, 5, 6, 7
      WriteLn(I)
    end

    for I in range(0, 20, 5) do // 0, 5, 10, 15
      WriteLn(I)
    end

### Case Statements

    case Command of
      "help", "?":
        ShowHelp()
      "quit", "exit":
        Shutdown()
      else
        WriteLn(f"Unknown: {Command}")
    end

Integer cases support ranges:

    case Score of
      0:        WriteLn("Zero")
      1..59:    WriteLn("Fail")
      60..79:   WriteLn("Pass")
      80..100:  WriteLn("Excellent")
    end

### Break and Continue

    for I in range(100) do
      if I = 50 then break end
      if I mod 2 = 0 then continue end
      WriteLn(I)   // prints odd numbers 1, 3, 5, ... 49
    end

---

## Chapter 4: Functions

### Defining Functions

    func Add(A: Integer, B: Integer) -> Integer
      return A + B
    end

    local Sum := Add(3, 4)   // 7

When there is no return type, the function returns nothing:

    func Greet(const Name: String)
      WriteLn(f"Hello, {Name}!")
    end

### Default Parameters

    func Connect(Host: String, Port: Integer = 8080) -> Boolean
      WriteLn(f"Connecting to {Host}:{Port}")
      return true
    end

    Connect("localhost")        // port 8080
    Connect("localhost", 3000)  // port 3000

### Named Arguments

    func SendEmail(To: String, Subject: String, Body: String)
      WriteLn(f"To: {To}, Subject: {Subject}")
    end

    // Named (any order)
    SendEmail(Subject: "Hello", Body: "Hi", To: "kim@example.com")

    // Mixed: positional first, then named
    SendEmail("kim@example.com", Body: "Hi", Subject: "Hello")

### Multiple Return Values

    func DivMod(A: Integer, B: Integer) -> (Integer, Integer)
      return A div B, A mod B
    end

    local Q, R := DivMod(17, 5)
    WriteLn(f"Quotient: {Q}, Remainder: {R}")

### Recursion

    func Factorial(N: Integer) -> Integer
      if N <= 1 then return 1 end
      return N * Factorial(N - 1)
    end

    WriteLn(Factorial(10))   // 3628800

---

## Chapter 5: Collections: Arrays and Dictionaries

### Arrays

    local Numbers := [1, 2, 3, 4, 5]
    local Names := ["Alice", "Bob", "Charlie"]
    local Empty := []

    WriteLn(Numbers[0])    // 1  (0-based indexing)
    Numbers[1] := 99
    WriteLn(Length(Numbers))  // 5

### Array Slicing

    local A := [10, 20, 30, 40, 50]
    WriteLn(A[1:3])     // [20, 30]
    WriteLn(A[:-1])     // [10, 20, 30, 40]  (all but last)
    WriteLn(A[2:])      // [30, 40, 50]
    WriteLn(A[:])       // full copy

Negative indices count from the end.

### Array Operations

    local C := [1, 2, 3] + [4, 5, 6]          // concatenation
    local D := [1, 2, 3, 4, 5] - [2, 4]       // difference: [1, 3, 5]
    local E := [1, 2, 3, 4, 5] * [2, 4, 6]    // intersection: [2, 4]
    local Zeros := [0] * 10                    // repetition

### Array Methods

    local Arr := [10, 20, 30]
    Arr.Add(40)
    Arr.Insert(1, 15)
    Arr.Remove(0)
    WriteLn(Arr.IndexOf(30))   // 2
    WriteLn(Arr.Contains(99))  // false
    local Last := Arr.Pop()
    Arr.Reverse()
    Arr.Sort()

### Dictionaries

    local Config := dict{
      "host": "localhost",
      "port": 8080,
      "debug": true
    }
    WriteLn(Config["host"])

    // Safe access with default
    local Val := get(Config, "timeout", 5000)

    // Check existence
    if haskey(Config, "debug") then
      WriteLn("debug mode")
    end

    // Iterate
    for Pair in Config do
      WriteLn(f"{Pair.Key} = {Pair.Value}")
    end

### Auto-Defaulting Dictionaries

Missing keys return nil, which coerces to 0 in numeric context:

    local Freq := dict{}
    local Words := ["apple", "banana", "apple", "cherry", "apple"]
    for W in Words do
      Freq[W] := Freq[W] + 1
    end
    // Freq = {"apple": 3, "banana": 1, "cherry": 1}

---

# Part II: Working with Text and Data

---

## Chapter 6: Strings and Text Processing

### String Literals

Both single and double quotes work identically:

    local S1 := "Hello, World!"
    local S2 := 'Hello, World!'

### Escape Sequences

    local Line := "First\nSecond"      // newline
    local Tab := "Col1\tCol2"          // tab
    local Path := "C:\\Users\\test"    // backslash

### Raw Strings

Prefix with `r` to skip escape processing -- essential for regex:

    local Pattern := r"\d{4}-\d{2}-\d{2}"

### Triple-Quoted Strings

    local SQL := """
        SELECT *
        FROM users
        WHERE age > 18
        """
    // Leading indent is automatically stripped

### F-Strings

Embed any expression inside curly braces:

    local Name := "World"
    WriteLn(f"Hello, {Name}!")
    WriteLn(f"Math: {2 + 2}")
    WriteLn(f"Func: {Sqrt(144)}")

Triple-quoted f-strings work for multiline formatted text:

    local Html := f"""
        <html>
            <h1>{Title}</h1>
            <p>{Items} items found</p>
        </html>
        """

### String Slicing

    local S := "Hello, World!"
    WriteLn(S[0:5])    // "Hello"
    WriteLn(S[-6:])    // "orld!"

### String Methods

    local S := "hello world"
    WriteLn(S.Replace("hello", "hi"))
    WriteLn(S.Split(" "))
    WriteLn(S.StartsWith("hello"))
    WriteLn(S.Contains("world"))
    WriteLn(S.ToUpper())
    WriteLn(S.Trim())

### Utility Functions

    local CSV := Join(", ", ["Alice", "Bob", "Charlie"])
    local Line := RepeatStr("-", 40)
    local Num := PadLeft("42", 6, "0")   // "000042"

---

## Chapter 7: Pattern Matching with Regex

### The matches Operator

    // Boolean test
    if Email matches r"^.+@.+\..+$" then
      WriteLn("Valid email")
    end

### Capturing Groups

    local M := "Error 404: Not Found" matches r"Error (\d+): (.+)"
    if M then
      WriteLn(M[1])    // "404"
      WriteLn(M[2])    // "Not Found"
    end

### Binding to Variables

    local Log := "2025-03-15 14:30:22 [ERROR] Timeout"
    if Log matches r"(\d{4}-\d{2}-\d{2}) .* \[(\w+)\] (.+)" into Date, Level, Msg then
      WriteLn(f"Date: {Date}, Level: {Level}, Message: {Msg}")
    end

### Regex Functions

    RegexMatch("Hello 123", r"\d+")            // true
    RegexFind("Error 404", r"\d+")             // "404"
    RegexFindAll("a1 b22 c333", r"\d+")        // ["1", "22", "333"]
    RegexReplace("Hello   World", r"\s+", " ") // "Hello World"
    RegexSplit("one,two,,three", ",+")          // ["one", "two", "three"]

---

## Chapter 8: Tuples: Returning Multiple Values

    local Pair := (42, "Hello")
    WriteLn(Pair[0])    // 42
    WriteLn(Pair[1])    // "Hello"

    // Destructuring
    local X, Y := (10, 20)

    // From functions
    func MinMax(Arr: TArray<Integer>) -> (Integer, Integer)
      local Lo := Arr[0]
      local Hi := Arr[0]
      for V in Arr do
        if V < Lo then Lo := V end
        if V > Hi then Hi := V end
      end
      return Lo, Hi
    end

    local Min, Max := MinMax([5, 2, 8, 1, 9])

Tuples are immutable -- you cannot change individual elements.

---

## Chapter 9: Error Handling

### Try / Except

    try
      local Result := 10 / 0
    except on E: Exception do
      WriteLn(f"Error: {E.Message}")
    end

### Try / Finally

    local F := open("file://data.txt")
    try
      ProcessData(F.Read())
    finally
      close(F)
    end

### Raise

    func Divide(A: Double, B: Double) -> Double
      if B = 0 then
        raise Exception.Create("Division by zero")
      end
      return A / B
    end

### Assert

    assert Length(Data) > 0
    assert Index >= 0, "Index must be non-negative"

---

# Part III: Organizing Code

---

## Chapter 10: Object-Oriented Programming

### Classes

    class TAnimal(TObject)
      private
        field FName: String
        field FAge: Integer
      end
      public
        constructor Create(const AName: String, AAge: Integer)
          FName := AName
          FAge := AAge
        end

        func Speak() -> String virtual
          return FName + " makes a sound"
        end

        prop Name: String read FName
        prop Age: Integer read FAge write FAge
      end
    end

### Inheritance

    class TDog(TAnimal)
      public
        func Speak() -> String override
          return Name + " says Woof!"
        end
      end
    end

    var Dog := create TDog("Rex", 5)
    WriteLn(Dog.Speak())    // "Rex says Woof!"
    free Dog

### Auto-Constructor

When you do not write an explicit constructor, arguments map to fields in order:

    class TPoint(TObject)
      public
        field X: Double
        field Y: Double
      end
    end

    var P := create TPoint(3.0, 4.0)

### Records (Value Types)

    record TVector2D
      field X: Double
      field Y: Double
      func Length() -> Double
        return Sqrt(X * X + Y * Y)
      end
    end

### Interfaces

    interface IDrawable(IInterface)
      func Draw()
    end

    class TCircle(TObject, IDrawable)
      public
        field FRadius: Double
        func Draw()
          WriteLn(f"Drawing circle r={FRadius}")
        end
      end
    end

### Enumerations

    enum TColor
      Red
      Green
      Blue
    end

---

## Chapter 11: Lambdas and Higher-Order Functions

### Lambdas

    local Double := lambda(X: Integer) -> Integer
      return X * 2
    end
    WriteLn(Double(5))    // 10

### Higher-Order Functions

    local Data := [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    local Evens := filter(Data, lambda(X: Integer) -> Boolean
      return X mod 2 = 0
    end)

    local Doubled := map(Data, lambda(X: Integer) -> Integer
      return X * 2
    end)

    local Sum := reduce(Data, lambda(Acc: Integer, X: Integer) -> Integer
      return Acc + X
    end, 0)

Complete list: filter, map, reduce, any, all, sorted, reversed, enumerate, zip.

### Closures

    func MakeCounter() -> TFunc<Integer>
      local Count := 0
      return lambda() -> Integer
        Count += 1
        return Count
      end
    end

### The Pipe Operator

Chain function calls left to right:

    local Result := Data |> ValidateOrder() |> RenderInvoice() |> HtmlToPdf()

    // Equivalent to:
    local Result := HtmlToPdf(RenderInvoice(ValidateOrder(Data)))

---

## Chapter 12: Libraries and Modules

### Creating a Library

    library MyMath
      func Factorial(N: Integer) -> Integer
        if N <= 1 then return 1 end
        return N * Factorial(N - 1)
      end
    end

### Using a Library

    uses MyMath
    WriteLn(Factorial(10))

### Library with Private Helpers

    library MyMath
    interface
      func GCD(A: Integer, B: Integer) -> Integer
    implementation
      func EuclidHelper(A: Integer, B: Integer) -> Integer
        // private
        while B <> 0 do
          local T := B
          B := A mod B
          A := T
        end
        return A
      end
      func GCD(A: Integer, B: Integer) -> Integer
        return EuclidHelper(Abs(A), Abs(B))
      end
    end

---

# Part IV: Data Safety with Contracts

---

## Chapter 13: Contracts: Data You Can Trust

### The Problem Contracts Solve

Every program receives data from the outside world -- from users, APIs, databases, files, other programs. And that data is frequently wrong: missing fields, wrong types, out-of-range values, malicious input.

Most languages leave validation to the developer. You write if-checks, you write validation functions, you hope you remembered everything. The validation code is scattered across your program, often duplicated, and easy to forget.

MIMERCode takes a different approach. A **contract** declares the exact shape of valid data in one place. The runtime enforces it automatically. If invalid data arrives, it is rejected before your code ever sees it.

### Your First Contract

    contract Customer
      Name:   required String minlen(1) maxlen(200),
      Email:  required String like,
      Age:    optional Integer range(0, 150),
      Active: default true Boolean
    end

This says:
- Name must be provided, 1-200 characters
- Email must be provided
- Age is optional, but if present must be 0-150
- Active defaults to true if not provided

### Creating a Contract Instance

    local C := Customer {
      Name: "Kim",
      Email: "kim@example.com",
      Age: 42
    }
    WriteLn(C.Name)      // "Kim"
    WriteLn(C.Active)    // true (default applied)

Invalid data raises an immediate error:

    // Raises "Name: minlen(1) constraint violated"
    local Bad := Customer { Name: "", Email: "test@test.com" }

### Constraints

| Constraint | Applies To | Meaning |
|---|---|---|
| minlen(N) | String | Minimum length |
| maxlen(N) | String | Maximum length |
| range(Min, Max) | Number | Value must be in [Min, Max] |
| gte(N) | Number | Greater than or equal |
| lte(N) | Number | Less than or equal |
| oneof("A", "B") | String | Must be one of the listed values |

### Why Contracts Matter

**1. Validation runs once, at the boundary.** Without contracts, you validate in every function. With contracts, you validate once when data enters your program. Everything downstream knows the data is valid.

**2. The shape is the documentation.** A contract declaration is simultaneously the data definition, the validation rules, and the API documentation. Nothing to get out of sync.

**3. AI-generated code is safe by default.** When an LLM generates a MIMERCode program, contracts ensure that even if the LLM makes mistakes in business logic, invalid data can never silently corrupt your system.

**4. Security is built in, not bolted on.** Sensitive data can be marked in the contract itself.

### Sensitive Fields

    contract PaymentRequest
      CardNumber: required String sensitive,
      CVV:        required String sensitive,
      Amount:     required Double gte(0)
    end

Sensitive fields are **sealed** at creation:

    local Pay := PaymentRequest {
      CardNumber: "4111111111111111",
      CVV: "123",
      Amount: 99.50
    }
    WriteLn(Pay.CardNumber)          // "****" (masked!)
    WriteLn(unseal(Pay.CardNumber))  // "4111111111111111"

This means logging cannot accidentally leak card numbers, error messages cannot expose secrets, and the only way to access the real value is the explicit unseal() call, creating a clear audit trail.

### Contract Inheritance

    contract Pageable
      Page:     default 1 Integer range(1, 9999),
      PageSize: default 50 Integer range(1, 200)
    end

    contract UserSearch : Pageable
      Name: optional String like,
      City: optional String eq
    end

UserSearch inherits Page and PageSize from Pageable.

### Authorization

    contract ViewUser requires role("user")
      UserId: required Integer
    end

    contract DeleteUser requires role("admin")
      UserId: required Integer
    end

When used at HTTP handler boundaries, the runtime checks roles automatically. Unauthorized requests get HTTP 403 before the handler executes.

### Contract-Bound Functions

The `as` keyword binds contract validation to function parameters
and return values. This means the function never needs to validate
its own input -- the contract has already done it.

First, define the contracts:

    contract OrderData
      OrderId:  required Integer,
      Total:    required Double gte(0),
      Currency: default "USD" String oneof("USD", "EUR", "GBP")
    end

    contract OrderResult
      Status:  required String oneof("ok", "error"),
      OrderId: required Integer,
      Message: optional String
    end

Then use `as` in the function signature:

    func ProcessOrder(Input as OrderData) as OrderResult
      // At this point, Input is guaranteed to be valid:
      // - OrderId is present and is an Integer
      // - Total is present, is a Double, and is >= 0
      // - Currency is one of "USD", "EUR", "GBP"
      WriteLn(f"Processing order {Input.OrderId} for {Input.Total} {Input.Currency}")
      return OrderResult { Status: "ok", OrderId: Input.OrderId }
    end

What happens at runtime:

- **On entry:** The argument is validated against `OrderData`. If any
  field is missing, wrong type, or violates a constraint, an error
  is raised before the function body executes.
- **On exit:** The return value is validated against `OrderResult`.
  If the return value does not match the output contract, an error
  is raised.
- **On error:** If the function raises an error, any sensitive fields
  in the error message are automatically masked.

---

# Part V: Composable Workflows

---

## Chapter 14: Pipelines: Building Reliable Workflows

### The Problem Pipelines Solve

Real-world programs rarely do just one thing. Processing an invoice means: validate the order, look up the customer, check inventory, calculate tax, render a PDF, send an email, update the database. Each step depends on the previous one. Some steps can run in parallel. Any step can fail.

Without pipelines, this logic is scattered across nested function calls and ad-hoc error handling. Adding a new step means modifying existing code. Reordering steps means rewriting control flow. Monitoring which step failed requires manual logging.

MIMERCode pipelines solve all of these problems.

### Your First Pipeline

Before defining a pipeline, you need the contracts it will use.
These define the shape of data flowing between steps:

    contract OrderData
      OrderId:  required Integer,
      Total:    required Double gte(0),
      Customer: required String minlen(1)
    end

    contract DeliveryPackage
      OrderId:   required Integer,
      Customer:  required String,
      PdfBytes:  required String,
      Timestamp: required String
    end

You also need the functions that do the actual work. Each function
takes input and produces output -- the pipeline connects them:

    func ValidateOrder(Input as OrderData) as OrderData
      // Check inventory, verify totals, etc.
      return Input
    end

    func EnrichCustomer(Order as OrderData) -> String
      // Look up customer details from database
      return f"Customer: {Order.Customer} (verified)"
    end

    func RenderOrder(Order as OrderData) -> String
      // Generate HTML invoice
      return f"<html><h1>Invoice #{Order.OrderId}</h1></html>"
    end

    func HtmlToPdf(Html: String) -> String
      // Convert HTML to PDF bytes
      return "[PDF bytes]"
    end

    func Assemble(Customer: String, Pdf: String) as DeliveryPackage
      return DeliveryPackage {
        OrderId: 42, Customer: Customer,
        PdfBytes: Pdf, Timestamp: ToISO8601(Now)
      }
    end

Now the pipeline connects these functions into a workflow:

    pipeline InvoiceProcess
      input as OrderData
      output as DeliveryPackage

      Validated := ValidateOrder(Input)
      Customer := EnrichCustomer(Validated)
      Pdf := Validated |> RenderOrder() |> HtmlToPdf()
      return Assemble(Customer, Pdf)
    end

Call it like a function:

    local Order := OrderData { OrderId: 42, Total: 199.99, Customer: "Kim" }
    local Package := InvoiceProcess(Order)

What happens:
1. Input is validated against OrderData
2. ValidateOrder runs, result bound to Validated
3. EnrichCustomer runs, result bound to Customer
4. RenderOrder and HtmlToPdf chain via pipe, result bound to Pdf
5. Assemble combines Customer and Pdf
6. Return value validated against DeliveryPackage

If any step fails, the pipeline reports which step failed, with what input, and what error.

### Fork: Parallel Execution

When steps are independent, run them simultaneously:

    pipeline InvoiceProcess
      input as OrderData
      output as DeliveryPackage

      Validated := ValidateOrder(Input)

      Customer, Pdf := fork Validated
        => EnrichCustomer()
        => RenderOrder() |> HtmlToPdf()
      end

      return Assemble(Customer, Pdf)
    end

Each => branch runs in a separate thread. The pipeline waits for all branches to complete.

**Pipelines are sequential by default.** This is deliberate. Contract-bound functions may write to databases or call APIs. Automatic parallelization could execute a write before the validation that should have rejected it. The fork keyword makes parallelism explicit.

### Route: Conditional Branching

    pipeline ProcessOrder
      input as OrderData
      output as ProcessedOrder

      Validated := ValidateOrder(Input)

      Result := route Validated
        when Priority >= 3 => ExpressProcess()
        when Region = "EU" => EuComplianceProcess()
        else               => StandardProcess()
      end

      return Result
    end

### Per-Step Error Handling

    pipeline InvoiceProcess
      input as OrderData
      output as DeliveryPackage

      Validated := ValidateOrder(Input)
      Customer := EnrichCustomer(Validated) on error retry(3)
      Pdf := Validated |> RenderOrder() |> HtmlToPdf()
        on error skip
      return Assemble(Customer, Pdf)
    end

| Policy | What Happens |
|---|---|
| on error abort | Stop pipeline, propagate error (default) |
| on error skip | Skip this step, continue |
| on error retry(N) | Retry up to N times |
| on error fallback Func() | Call alternative function |

### Pipeline Observability

    ConfigLoad('{"pipelines": {"logging": true, "timing": true, "tracing": true}}')
    LogSetLevel("debug")
    local Result := InvoiceProcess(Order)

Output:

    [INFO] [abc-123] [pipeline] START InvoiceProcess
    [DEBUG] [abc-123] [pipeline]   STEP Validated (1.5 ms)
    [DEBUG] [abc-123] [pipeline]   STEP fork(Customer, Pdf)
    [DEBUG] [abc-123] [pipeline]     FORK 2 branches completed (3.2 ms)
    [INFO] [abc-123] [pipeline] END InvoiceProcess (total: 5.1 ms)

### Config-Driven Pipelines

Change steps without changing code. Define in JSON:

    {
      "pipelines": {
        "Invoice": {
          "input": "OrderData",
          "output": "DeliveryPackage",
          "steps": [
            {"name": "V", "func": "ValidateOrder", "input": "Input"},
            {"name": "H", "func": "RenderOrder", "input": "V"},
            {"name": "P", "func": "HtmlToPdf", "input": "H"}
          ],
          "return": "P"
        }
      }
    }

Load and run:

    ConfigLoadFile("pipeline_config.json")
    local P := LoadPipeline("Invoice")
    local Result := P(Order)

### Dynamic Pipeline Construction

    local P := CreatePipeline("OrderData", "Pdf")
    P := PipelineAdd(P, "V", "ValidateOrder", "Input")
    P := PipelineAdd(P, "H", "RenderOrder", "V")
    P := PipelineAdd(P, "P", "HtmlToPdf", "H")
    local Runner := PipelineRun(P)
    local Result := Runner(Order)

### When to Use Pipelines vs Pipe Operator

| Need | Use |
|---|---|
| Simple linear chain | Pipe operator |
| Per-step error policies | Pipeline |
| Parallel execution | Pipeline with fork |
| Conditional branching | Pipeline with route |
| Config-driven assembly | Pipeline with LoadPipeline |
| Execution logging | Pipeline with observability |

---

# Part VI: Channels and I/O

---

## Chapter 15: Channels: One Pattern for All I/O

MIMERCode uses channels for all external communication. The pattern is always the same:

    open  -> use -> close    (client: you consume data)
    serve -> on  -> close    (server: you produce data)

### File Channel

    local F := open("file://data/config.json")
    local Content := F.Read()
    close(F)

All paths are sandboxed. Path traversal (../) is rejected. File methods include: Read, ReadLines, Write, Append, List, Exists, IsDir, IsFile, Size, DeleteFile, Mkdir, CopyFile, MoveFile.

### HTTP Client Channel

    local Api := open("https://api.example.com/v1")
    local Users := Api.Get("/users")
    local Result := Api.Post("/users", '{"name": "Kim"}')
    close(Api)

### Database Channel

    local DB := open("db://localhost/myapp")
    local Rows := DB.Query("SELECT * FROM users WHERE age > 18")
    close(DB)

---

## Chapter 16: HTTP Servers and Authentication

### Serving HTTP

    local Web := serve("http://0.0.0.0:8080")

    on Web.Get("/") as Req: HttpRequest
      return "<html><h1>Hello!</h1></html>"
    end

    on Web.Get("/users/{id}") as Req: ViewUser
      return f"User {Req.id}"
    end

### Authentication

    local Auth := open("auth://users.json")
    local Web := serve("http://0.0.0.0:8080", Auth)

    Auth("create", dict{
      "Username": "kim", "Password": "secret", "Roles": ["admin"]
    })

    on Web.Post("/api/login") as Req: LoginRequest
      local Result := Auth("login", dict{
        "Username": unseal(Req.Username),
        "Password": unseal(Req.Password)
      })
      if Result.Success then
        return HttpResponse {
          Status: 200,
          Body: '{"token": "' + Result.Token + '"}',
          Headers: dict{"Set-Cookie": "token=" + Result.Token + "; Path=/; HttpOnly"}
        }
      end
      return HttpResponse { Status: 401, Body: "Login failed" }
    end

Features: SHA-256 password hashing, JWT tokens (HS256), automatic token extraction from headers and cookies, role-based access control.

---

## Chapter 17: Templates

    local Data := dict{ "Name": "Kim", "Items": 3 }
    local Html := render(Data, """
        <h1>Hello, {{Name}}!</h1>
        <p>{{Items}} items in cart</p>
        """)

Syntax: `{{Field}}` for escaped output, `{{{Field}}}` for raw, `{{#if}}`, `{{#each}}`, `{{@index}}`. Sensitive contract fields are automatically masked.

---

## Chapter 18: Configuration and Logging

### Configuration

    ConfigLoadFile("config.json")
    local Name := ConfigGet("app.name")
    local Port := ConfigGetInt("app.port")
    local Debug := ConfigGetBool("app.debug", false)
    ConfigSet("app.custom", "value")

### Logging

    LogDebug("verbose detail")
    LogInfo("pipeline", "Processing order 42")
    LogWarn("Deprecation warning")
    LogError("Connection failed")
    LogAudit("auth", "Admin accessed sensitive data")

    LogSetLevel("warn")          // only warn, error, audit shown
    local Trace := LogNewTraceId()  // correlate related entries

---

# Part VII: Mathematics and Science

---

## Chapter 19: Math, Statistics, and Linear Algebra

### Constants

pi, e, tau, inf, nan are pre-defined.

### Scalar Math

    WriteLn(Abs(-5))           // 5
    WriteLn(Sqrt(144))         // 12.0
    WriteLn(Power(2, 10))      // 1024.0
    WriteLn(clamp(15, 0, 10))  // 10
    WriteLn(factorial(10))     // 3628800
    WriteLn(gcd(48, 18))       // 6

### Trigonometry

    WriteLn(sin(pi / 2))       // 1.0
    WriteLn(degrees(pi))       // 180.0
    WriteLn(radians(90))       // 1.5707...

### Random Numbers

    seed(42)
    WriteLn(randint(1, 6))             // dice roll
    WriteLn(uniform(0.0, 1.0))         // float
    WriteLn(normal(100, 15))           // bell curve
    WriteLn(choice(["a", "b", "c"]))   // random pick
    local Deck := shuffle(range(52))

### Statistics

    local Data := [4, 8, 15, 16, 23, 42]
    WriteLn(median(Data))              // 15.5
    WriteLn(stdev(Data))               // 13.28...
    WriteLn(variance(Data))            // 176.56...
    WriteLn(percentile(Data, 75))      // 27.75
    WriteLn(corrcoef([1,2,3], [2,4,6]))  // 1.0

### Array Operations

    local A := arange(0, 10, 2)        // [0, 2, 4, 6, 8]
    local B := cumsum([1, 2, 3, 4])    // [1, 3, 6, 10]
    local C := diff([1, 4, 9, 16])     // [3, 5, 7]
    local D := unique([1, 2, 2, 3])    // [1, 2, 3]

### Vectors and Matrices

    local V := vector([1.0, 2.0, 3.0])
    local W := vector([4.0, 5.0, 6.0])
    WriteLn(V + W)          // [5.0, 7.0, 9.0]
    WriteLn(dot(V, W))      // 32.0
    WriteLn(norm(V))        // 3.741...

    local M := identity(3)
    WriteLn(det(M))         // 1.0
    WriteLn(transpose(M))

### Data Formats: JSON and CSV

MIMERCode includes built-in functions for parsing and generating
JSON and CSV data without external libraries.

**JSON:**

    // Parse a JSON string into MIMERCode values (dicts, arrays, etc.)
    local Data := json_parse('{"name": "Kim", "age": 42, "tags": ["admin"]}')
    WriteLn(Data["name"])    // "Kim"
    WriteLn(Data["tags"][0]) // "admin"

    // Convert MIMERCode values back to a JSON string
    local Json := json_stringify(Data)        // compact
    local Pretty := json_stringify(Data, 2)   // pretty-printed with 2-space indent

| Function | Description |
|---|---|
| json_parse(str) | Parse JSON string to MIMERCode value. Objects become dicts, arrays become arrays, numbers become int or float, booleans and null map directly |
| json_stringify(value) | Convert any MIMERCode value to compact JSON string. NaN and Infinity become null |
| json_stringify(value, indent) | Pretty-printed JSON with given indent spaces per level |

**CSV:**

    // Parse CSV into array of arrays (raw mode)
    local Rows := csv_parse("Name,Age\nAlice,30\nBob,25")
    // [["Name", "Age"], ["Alice", "30"], ["Bob", "25"]]

    // Parse CSV into array of dicts (using first row as headers)
    local People := csv_parse("Name,Age\nAlice,30\nBob,25",
      dict{ "headers": true })
    // [{"Name": "Alice", "Age": "30"}, {"Name": "Bob", "Age": "25"}]

    // Parse TSV (tab-separated)
    local Tsv := csv_parse(TsvText, dict{ "delimiter": "\t" })

    // Generate CSV from array of dicts
    local Output := csv_stringify(People)
    // "Name,Age\r\nAlice,30\r\nBob,25\r\n"

    // Generate CSV from array of arrays
    local Raw := csv_stringify([["A", "B"], ["1", "2"]])

| Function | Description |
|---|---|
| csv_parse(str) | Parse CSV into array of arrays (each row is an array of field strings) |
| csv_parse(str, options) | Options dict: `headers` (bool, use first row as dict keys), `delimiter` (string, default ","), `quote` (string, default '"') |
| csv_stringify(data) | Convert array of dicts or array of arrays to CSV string. Dict mode auto-generates header row |
| csv_stringify(data, options) | Options: `delimiter`, `quote`, `headers` (bool, include header row, default true) |

The CSV parser handles quoted fields, escaped quotes (doubled ""),
and newlines inside quoted fields.

### Geographic Functions

MIMERCode includes a geographic function library for distance
calculations, coordinate projection, and polygon geometry. All
coordinates are in decimal degrees. Distances are in kilometers.
Bearings are in degrees (0 = North, 90 = East).

**Geodesic calculations:**

    // Distance between two points (Haversine great-circle)
    local Dist := geo_distance(55.6761, 12.5683, 56.1629, 10.2039)
    WriteLn(f"Copenhagen to Aarhus: {Dist:.1f} km")  // ~187 km

    // Bearing (initial heading) from point A to point B
    local Brg := geo_bearing(55.6761, 12.5683, 56.1629, 10.2039)
    WriteLn(f"Bearing: {Brg:.1f} degrees")

    // Destination point given start, bearing, and distance
    local Dest := geo_destination(55.6761, 12.5683, 270.0, 100.0)
    WriteLn(f"100km west: {Dest['lat']:.4f}, {Dest['lon']:.4f}")

    // Midpoint between two points
    local Mid := geo_midpoint(55.6761, 12.5683, 56.1629, 10.2039)

    // Interpolate along great circle (fraction 0.0 to 1.0)
    local Quarter := geo_interpolate(55.6761, 12.5683, 56.1629, 10.2039, 0.25)

    // Generate points along great circle path (for drawing routes)
    local Path := geo_great_circle(55.6761, 12.5683, 40.7128, -74.0060, 100)
    // Returns array of 101 {lat, lon} dicts

**Projection:**

    // Convert lat/lon to pixel coordinates (Mercator projection)
    local Bounds := [-180, -85, 180, 85]   // [min_lon, min_lat, max_lon, max_lat]
    local Pixel := geo_mercator(55.6761, 12.5683, 800, 600, Bounds)
    WriteLn(f"x={Pixel['x']:.0f}, y={Pixel['y']:.0f}")

    // Convert pixel coordinates back to lat/lon
    local Coord := geo_mercator_inv(400, 300, 800, 600, Bounds)

**Polygon geometry:**

    // Define a polygon as array of {lat, lon} points
    local Denmark := [
      dict{ "lat": 57.75, "lon": 8.08 },
      dict{ "lat": 57.75, "lon": 12.69 },
      dict{ "lat": 54.56, "lon": 12.69 },
      dict{ "lat": 54.56, "lon": 8.08 }
    ]

    // Point-in-polygon test (ray casting)
    local Inside := geo_contains(Denmark, 55.67, 12.57)  // true

    // Polygon area in square kilometers
    local Area := geo_area(Denmark)

    // Centroid (center of mass)
    local Center := geo_centroid(Denmark)

    // Bounding box
    local Box := geo_bounds(Denmark)
    // {min_lat, min_lon, max_lat, max_lon}

**Unit conversion:**

    local Miles := geo_km_to_miles(100)     // 62.137
    local Km := geo_miles_to_km(100)        // 160.934

    // Degrees-minutes-seconds to decimal degrees
    local Lat := geo_dms(55, 40, 34)        // 55.676...

| Function | Arguments | Returns | Description |
|---|---|---|---|
| geo_distance | lat1, lon1, lat2, lon2 | Float (km) | Haversine great-circle distance |
| geo_bearing | lat1, lon1, lat2, lon2 | Float (degrees) | Initial bearing (0=N, 90=E) |
| geo_destination | lat, lon, bearing, dist_km | {lat, lon} | Point at distance along bearing |
| geo_midpoint | lat1, lon1, lat2, lon2 | {lat, lon} | Midpoint on great circle |
| geo_interpolate | lat1, lon1, lat2, lon2, fraction | {lat, lon} | Point at fraction (0-1) along great circle |
| geo_great_circle | lat1, lon1, lat2, lon2, steps | Array of {lat, lon} | Points along great circle path |
| geo_mercator | lat, lon, width, height, bounds | {x, y} | Project to pixel coordinates |
| geo_mercator_inv | x, y, width, height, bounds | {lat, lon} | Pixel to geographic coordinates |
| geo_contains | polygon, lat, lon | Boolean | Point-in-polygon test |
| geo_area | polygon | Float (km2) | Polygon area on Earth surface |
| geo_centroid | polygon | {lat, lon} | Center of mass |
| geo_bounds | points | {min_lat, min_lon, max_lat, max_lon} | Bounding box |
| geo_km_to_miles | km | Float | Kilometers to miles |
| geo_miles_to_km | miles | Float | Miles to kilometers |
| geo_dms | deg, min [, sec] | Float | DMS to decimal degrees |

Polygons are arrays of points. Each point can be a dict with `lat`
and `lon` keys, or a two-element array `[lat, lon]`.

### Version Introspection

MIMERCode provides built-in functions for querying the runtime
version and available features at runtime:

    WriteLn(MimerCodeVersion())
    // "1.2.0"

    local Info := MimerCodeVersionFull()
    // Dict with: version, major, minor, patch, build,
    //   build_date, lang_version, product, copyright

    WriteLn(MimerCodeBuildDate())
    // "2026-04-06"

    local Features := MimerCodeFeatures()
    // Array of available channel schemes and capabilities:
    // ["file", "http", "https", "auth", "db", "gui"]

    if MimerCodeHasFeature("gui") then
      WriteLn("GUI support available")
    end

| Function | Returns | Description |
|---|---|---|
| MimerCodeVersion() | String | Version string (e.g. "1.2.0") |
| MimerCodeVersionFull() | Dict | Full version info: version, major, minor, patch, build, build_date, lang_version, product, copyright |
| MimerCodeBuildDate() | String | Build date string |
| MimerCodeFeatures() | Array | List of registered channel schemes and features |
| MimerCodeHasFeature(name) | Boolean | Check if a specific feature/scheme is available |

---

# Part VIII: Building GUIs

---


## Chapter 20: Views: Declarative User Interfaces

GUI programs use the GUI runner:

    MIMERCodeRunnerGUI myapp.mc

### Your First GUI

    view Counter
      state
        Count := 0
      end
      func Increment()
        Count := Count + 1
      end
      render
        vbox padding: 16, gap: 8
          label text: f"Count: {Count}" end
          button text: "+", on_click: Increment end
        end
      end
    end

    local App := serve("gui://Counter",
      title: "My Counter",
      width: 300, height: 200
    )

The `"gui://Counter"` URI finds the view named `Counter` and mounts
it automatically. Alternatively: `serve("gui://", view: "Counter")`.

For multi-view applications, mount views explicitly after creation:

    local App := serve("gui://", title: "My App")
    App.Mount("LoginScreen")

### GUI Channel Options

| Option | Type | Default | Description |
|---|---|---|---|
| title | String | "MIMERCode" | Window title |
| width | Integer | 800 | Window width in pixels |
| height | Integer | 600 | Window height in pixels |
| theme | String | "Dark" | "Dark" or "Light" |
| resizable | Boolean | true | Allow window resize |

### View Structure

Every view has up to four sections:

    view MyView
      props
        Title: required String,
        ShowFooter: default true Boolean
      end

      state
        Items := [],
        SearchText := "",
        SelectedIndex := -1
      end

      func HandleSearch(Text: String)
        SearchText := Text
      end

      render
        vbox padding: 16, gap: 8
          label text: Title end
          textinput value: SearchText, placeholder: "Search...",
            on_change: HandleSearch
          end
        end
      end
    end

**Props** use the same syntax as contracts: `required`, `optional`,
`default <value>`. Props are immutable inside the view.

**State** fields must have defaults so the view can render immediately.
Assigning to state inside a method triggers re-render after the
method completes. Multiple assignments in one method are batched
into a single re-render.

---

### Common Properties (All Widgets)

These properties are recognized by every widget.

**Content:**

| Property | Type | Description |
|---|---|---|
| text | String | Display text content |
| value | String | Alias for text (used on inputs) |
| placeholder | String | Gray text shown when value is empty |
| id | String | Unique identifier |
| key | String | Identity key for list diffing (required in for loops) |
| tooltip | String | Hover tooltip text |
| shortcut | String | Keyboard shortcut (see Keyboard Shortcuts below) |
| transition | String | Animated style change (see Transitions section below) |

**State:**

| Property | Type | Description |
|---|---|---|
| enabled | Boolean | When false, grayed out and non-interactive |
| wrap | Boolean | Text wrapping |
| visible | Boolean | Show or hide the widget |
| focus_ring | Boolean | Draw focus ring when focused |

**Layout:**

| Property | Type | Description |
|---|---|---|
| padding | Number/Tuple | Inner spacing. Number, (v, h), or (top, right, bottom, left) |
| gap | Number | Space between children |
| flex | Number | Share of remaining space. 0 = intrinsic size, 1+ = grow |
| width | Number | Fixed width in pixels. -1 for auto |
| height | Number | Fixed height in pixels. -1 for auto |
| min_width | Number | Minimum width constraint |
| min_height | Number | Minimum height constraint |
| max_width | Number | Maximum width. -1 for no limit |
| max_height | Number | Maximum height. -1 for no limit |
| justify | String | Main-axis: "start", "center", "end", "space_between", "space_around", "space_evenly" |
| align | String | Cross-axis: "start", "center", "end", "stretch" |
| overflow | String | Content overflow: "visible", "clip", "scroll", "ellipsis" |
| direction | String | Layout direction: "horizontal" (row) or "vertical" (column) |

**Visual:**

| Property | Type | Description |
|---|---|---|
| background | Color/Ref | Hex ("#ff0000") or theme reference ("surface", "primary") |
| foreground | Color/Ref | Text/content color |
| border_color | Color/Ref | Border color |
| border_width | Number | Border thickness in pixels |
| radius | Number | Corner radius in pixels |
| opacity | Number | 0.0 = invisible, 1.0 = opaque |
| font_size | Number | Font size override |
| font_weight | String | "bold" or "" |
| text_align | String | Text alignment: "left", "center", "right" |

---

### Common Events (All Widgets)

Any property starting with `on_` is an event handler. The handler
can be a named method or an inline lambda:

    // Named method
    button text: "Save", on_click: HandleSave end

    // Inline lambda with no parameter
    button text: "Clear", on_click: func() Count := 0 end end

    // Inline lambda with parameter
    textinput value: Name, on_change: func(V) Name := V end end

| Event | Callback | Description |
|---|---|---|
| on_click | func() | Widget clicked |
| on_change | func(newValue) | Value changed (inputs) |
| on_submit | func(value) | Enter (textinput) or Ctrl+Enter (textarea) |
| on_mouseenter | func() | Mouse entered widget |
| on_mouseleave | func() | Mouse left widget |
| on_mousedown | func() | Mouse button pressed |
| on_mouseup | func() | Mouse button released |
| on_keydown | func(keyInfo) | Key pressed while focused |
| on_select | func(index) | Selection changed (lists, tables, trees) |
| on_contextmenu | func() | Right-click |

---

### Keyboard Shortcuts

The `shortcut` property attaches a keyboard shortcut to any widget.
When the user presses the key combination, the widget's `on_click`
handler fires -- even if the widget is not focused or visible on
screen. This works on buttons, menuitems, labels, or any widget
with an `on_click` handler.

    // Shortcut on a button
    button text: "Save", shortcut: "Ctrl+S", on_click: HandleSave end

    // Shortcut on a menuitem (displayed right-aligned in the menu)
    menuitem label: "Undo", shortcut: "Ctrl+Z", on_click: HandleUndo end

    // Shortcut on a hidden button (keyboard-only action)
    button text: "", visible: false, shortcut: "F5",
      on_click: HandleRun
    end

**Format:** Modifier keys joined with `+`, followed by the key name.
Case-insensitive.

**Modifiers:** `Ctrl`, `Alt`, `Shift` (combine with `+`)

**Key names:**

| Category | Keys |
|---|---|
| Letters | A-Z |
| Digits | 0-9 |
| Function keys | F1-F12 |
| Navigation | Up, Down, Left, Right, Home, End, PageUp, PageDown |
| Editing | Enter (or Return), Escape (or Esc), Delete (or Del), Backspace, Insert (or Ins), Tab, Space |

**Examples:**

    "Ctrl+S"         // Save
    "Ctrl+Shift+F"   // Find in files
    "F5"             // Run (no modifier)
    "Alt+F4"         // Close
    "Ctrl+1"         // Switch to tab 1

**Behavior:**
- Shortcuts on disabled widgets (`enabled: false`) do not fire
- When a text field has focus, standard text editing keys (Ctrl+C,
  Ctrl+V, Ctrl+X, Ctrl+A) are consumed by the text field and do
  not trigger widget shortcuts
- On menuitems, the shortcut text is displayed right-aligned as a
  visual hint to the user

---

### Transitions (Animated Property Changes)

When a widget's style changes (e.g. background color on hover),
the change normally happens instantly. The `transition` property
makes it animate smoothly over a duration instead.

**Format:** `"property duration easing, property duration easing, ..."`

    // Smooth hover effect: background fades over 300ms
    button text: "Hover me",
      background: if IsHovered then "primary" else "surface" end,
      transition: "background 300ms ease_in_out",
      on_mouseenter: func() IsHovered := true end,
      on_mouseleave: func() IsHovered := false end
    end

    // Multiple properties animated independently
    vbox padding: 16, opacity: if Visible then 1.0 else 0.0 end,
      transition: "opacity 500ms ease_out, background 200ms linear"
      label text: "Fading content" end
    end

    // Animated border on focus
    textinput value: Name,
      border_color: if Focused then "primary" else "border" end,
      border_width: 1,
      transition: "border_color 200ms ease_out",
      on_change: func(V) Name := V end
    end

**Animatable properties:**

| Property | Interpolation | Description |
|---|---|---|
| background | Color | Smoothly blends between two colors |
| border_color | Color | Smoothly blends border color |
| opacity | Float | Fades between transparency levels |
| scale | Float | Grows/shrinks the element |

**Duration:** Specified as `200ms` (milliseconds) or `1s` (seconds).
Default: 200ms.

**Easing functions:**

| Name | Description |
|---|---|
| linear | Constant speed |
| ease_in | Starts slow, accelerates (quadratic) |
| ease_out | Starts fast, decelerates (quadratic, default) |
| ease_in_out | Slow start and end, fast middle (quadratic) |
| ease_in_cubic | Starts slow, accelerates (cubic, more pronounced) |
| ease_out_cubic | Starts fast, decelerates (cubic, more pronounced) |
| ease_in_out_cubic | Slow start and end (cubic, smoother) |
| back_in | Pulls back slightly before moving forward |
| back_out | Overshoots target then settles back |
| back_in_out | Pulls back, overshoots, then settles |
| bounce_out | Bounces at the end like a dropped ball |
| elastic_out | Springs past target and oscillates to rest |

If omitted, easing defaults to `ease_out` and duration to `200ms`:

    // These are equivalent:
    transition: "background"
    transition: "background 200ms ease_out"

#### Named Transition Presets

Instead of writing full transition strings, you can use a preset
name. These are built into the theme:

| Preset Name | Expands To | Use Case |
|---|---|---|
| button_hover | background 200ms ease_out, scale 100ms ease_in | Button hover feedback |
| focus | border_color 150ms ease_in | Input focus border |
| fade | opacity 200ms ease_out | Fade in/out |
| expand | opacity 200ms ease_out, scale 250ms ease_out | Element appearing with growth |
| smooth | background 200ms ease_out, opacity 200ms ease_out | General smooth transitions |
| slide_in | opacity 300ms ease_out_cubic, scale 300ms ease_out_cubic | Entrance animation |
| slide_out | opacity 200ms ease_in_cubic, scale 200ms ease_in_cubic | Exit animation |
| pop | scale 300ms back_out, opacity 150ms ease_out | Playful pop-in with overshoot |
| bounce | scale 500ms bounce_out, opacity 200ms ease_out | Bouncy entrance |
| spring | scale 600ms elastic_out, opacity 200ms ease_out | Springy elastic entrance |
| color_shift | background 400ms ease_in_out_cubic | Slow smooth color change |
| gentle | background 300ms ease_in_out, opacity 300ms ease_in_out | Calm, slow transitions |
| highlight | background 150ms ease_in, scale 150ms back_out | Quick attention flash |

Example using presets:

    // Instead of writing the full string:
    button text: "Save",
      transition: "background 200ms ease_out, scale 100ms ease_in",
      ...
    end

    // Use the preset name:
    button text: "Save", transition: "button_hover", ... end

    // Pop-in effect for a notification
    if ShowNotification then
      label text: "Saved!", foreground: "success",
        transition: "pop"
      end
    end

    // Spring effect for a modal
    vbox padding: 24, background: "surface_raised",
      transition: "spring"
      label text: "Dialog content" end
    end

**How it works:** When the render block re-evaluates (because state
changed) and a transitioned property has a different value than
before, the animation system interpolates from the old value to the
new value over the specified duration. If the value changes again
mid-animation, the animation retargets from the current interpolated
position -- no jumping.

Transitions run at 60fps and are handled entirely by the rendering
engine. No timers or manual frame management required.

---

### Themes, Colors, Icons, and Fonts

Set the theme when creating the GUI channel:

    local App := serve("gui://MyView", theme: "Dark")

#### Theme Colors

Use these names as string values for background, foreground,
border_color and other color properties. They adapt automatically
to the active theme.

**Semantic Colors** (base and hover are identical in both themes;
_dim and on_ variants differ):

| Name | Dark | Light | Description |
|---|---|---|---|
| primary | #3498db | #3498db | Main interactive (blue) |
| primary_hover | #2980b9 | #2980b9 | Hover state |
| primary_dim | #1c3045 | #dbeafe | Tinted background |
| on_primary | #ffffff | #ffffff | Text on primary |
| secondary | #9b59b6 | #9b59b6 | Purple accent |
| secondary_hover | #8e44ad | #8e44ad | Hover state |
| secondary_dim | #2d1d3a | #f0e6f6 | Tinted background |
| on_secondary | #ffffff | #ffffff | Text on secondary |
| danger | #e74c3c | #e74c3c | Errors, destructive (red) |
| danger_hover | #c0392b | #c0392b | Hover state |
| danger_dim | #3a1f1f | #fde8e8 | Tinted background |
| on_danger | #ffffff | #ffffff | Text on danger |
| success | #27ae60 | #27ae60 | Positive (green) |
| success_hover | #219a52 | #219a52 | Hover state |
| success_dim | #1a3326 | #def7ec | Tinted background |
| on_success | #ffffff | #ffffff | Text on success |
| warning | #f39c12 | #f39c12 | Caution (amber) |
| warning_hover | #d68910 | #d68910 | Hover state |
| warning_dim | #3d310f | #fef3cd | Tinted background |
| on_warning | #1e1e1e | #2c3e50 | Text on warning (dark) |
| info | #17a2b8 | #17a2b8 | Informational (teal) |
| info_hover | #138496 | #138496 | Hover state |
| info_dim | #13303a | #d1ecf1 | Tinted background |
| on_info | #ffffff | #ffffff | Text on info |
| accent | #e67e22 | #e67e22 | Emphasis (orange) |
| accent_hover | #d35400 | #d35400 | Hover state |
| accent_dim | #3a2510 | #fde8d0 | Tinted background |
| on_accent | #ffffff | #ffffff | Text on accent |

**Surface Colors:**

| Name | Dark | Light | Description |
|---|---|---|---|
| background | #1e1e1e | #ffffff | App background |
| surface | #2d2d2d | #f8f9fa | Cards, panels |
| surface_hover | #383838 | #e9ecef | Hovered surface |
| surface_dim | #252525 | #f0f1f3 | Recessed areas |
| surface_alt | #333333 | #edf0f2 | Alternating rows |
| surface_raised | #3a3a3a | #ffffff | Elevated (dropdowns) |

**Text, Border, Input, Link, Overlay, Chart Colors:**

| Name | Dark | Light | Description |
|---|---|---|---|
| text | #d4d4d4 | #2c3e50 | Primary text |
| text_muted | #808080 | #7f8c8d | Secondary text |
| text_disabled | #555555 | #bdc3c7 | Disabled text |
| text_inverse | #1e1e1e | #ffffff | Opposite-background text |
| border | #404040 | #dee2e6 | Standard borders |
| border_strong | #606060 | #adb5bd | Emphasized borders |
| border_muted | #333333 | #e9ecef | Subtle borders |
| input_bg | #3c3c3c | #ffffff | Input background |
| input_border | #505050 | #ced4da | Input border |
| input_disabled | #2a2a2a | #e9ecef | Disabled input bg |
| placeholder | #666666 | #adb5bd | Placeholder text |
| focus_ring | #3498db | #3498db | Focus ring |
| link | #5dade2 | #2980b9 | Hyperlink |
| link_hover | #85c1e9 | #1a6da0 | Hovered link |
| overlay | #000000B3 | #00000066 | Modal backdrop |
| chart_1 | #3498db | #3498db | Series 1 (blue) |
| chart_2 | #e74c3c | #e74c3c | Series 2 (red) |
| chart_3 | #2ecc71 | #27ae60 | Series 3 (green) |
| chart_4 | #f39c12 | #f39c12 | Series 4 (amber) |
| chart_5 | #9b59b6 | #9b59b6 | Series 5 (purple) |
| chart_6 | #1abc9c | #1abc9c | Series 6 (teal) |

#### Theme Fonts

| Name | Face | Size | Description |
|---|---|---|---|
| default | Segoe UI | 14 | Body text |
| heading | Segoe UI Bold | 20 | Headings |
| small | Segoe UI | 11 | Captions |
| mono | Cascadia Code | 13 | Code, textarea font: "mono" |
| button | Segoe UI Bold | 13 | Button labels |

#### Built-In Icons

Use with `icon name: "..." end`. Each is a Material Design SVG path.

| Name | Description |
|---|---|
| add | Plus sign |
| arrow_back | Left-pointing arrow |
| arrow_down | Downward arrow |
| arrow_forward | Right-pointing arrow |
| arrow_up | Upward arrow |
| attach_file | Paper clip (attachment) |
| bar_chart | Bar chart graphic |
| bookmark | Filled bookmark flag |
| bookmark_outline | Outline bookmark flag |
| calendar | Calendar page |
| camera | Camera |
| chat | Speech bubble |
| check | Checkmark |
| check_circle | Checkmark in circle |
| chevron_down | Small down arrow |
| chevron_left | Small left arrow |
| chevron_right | Small right arrow |
| chevron_up | Small up arrow |
| clock | Clock face |
| close | X mark (close/dismiss) |
| cloud | Cloud |
| cloud_download | Cloud with down arrow |
| cloud_upload | Cloud with up arrow |
| code | Angle brackets (code) |
| copy | Two overlapping rectangles |
| dashboard | Dashboard grid |
| delete | Trash can |
| download | Down arrow into tray |
| drag_handle | Six dots (drag grip) |
| edit | Pencil |
| email | Envelope |
| error | Exclamation in circle |
| expand_less | Collapse arrow (up chevron) |
| expand_more | Expand arrow (down chevron) |
| file | Document with folded corner |
| filter_list | Funnel / filter lines |
| first_page | Skip to first (double left arrow) |
| flag | Flag |
| folder | Closed folder |
| folder_open | Open folder |
| fullscreen | Expand to fullscreen |
| heart | Filled heart |
| heart_outline | Outline heart |
| help | Question mark in circle |
| help_outline | Outline question circle |
| home | House |
| image | Landscape picture frame |
| info | Letter i in circle |
| last_page | Skip to last (double right arrow) |
| launch | External link / open in new |
| link | Chain link |
| lock | Padlock (locked) |
| login | Arrow entering door |
| logout | Arrow leaving door |
| menu | Three horizontal lines (hamburger) |
| more_horiz | Three horizontal dots |
| more_vert | Three vertical dots |
| notification | Bell |
| open | Open folder / open action |
| palette | Artist palette (colors) |
| pause | Two vertical bars |
| people | Group of people |
| person | Single person |
| phone | Telephone handset |
| pin | Map pin / location marker |
| play | Right-pointing triangle |
| print | Printer |
| redo | Forward curved arrow |
| refresh | Circular arrow |
| remove | Minus sign |
| save | Floppy disk |
| search | Magnifying glass |
| send | Paper airplane |
| settings | Gear / cog wheel |
| share | Share / forward symbol |
| skip_next | Next track (double right arrow) |
| skip_prev | Previous track (double left arrow) |
| sort | Sort arrows (up/down) |
| star | Five-pointed star (filled) |
| star_outline | Five-pointed star (outline) |
| stop | Square (stop playback) |
| sync | Circular sync arrows |
| table_chart | Table/grid chart |
| tag | Price tag / label |
| terminal | Terminal / command prompt |
| thumb_down | Thumbs down |
| thumb_up | Thumbs up |
| tune | Tuning sliders |
| undo | Backward curved arrow |
| unfold_more | Expand vertically |
| unlock | Padlock (unlocked) |
| upload | Up arrow from tray |
| visibility | Eye (show) |
| visibility_off | Eye with slash (hide) |
| volume_down | Speaker with one wave |
| volume_off | Speaker muted |
| volume_up | Speaker with waves |
| warning | Triangle with exclamation |

Example:

    hbox gap: 8
      icon name: "save", size: 16, color: "primary" end
      label text: "Save Document" end
    end

Tree views use `folder` and `file` icons by default.

---

### Layout Containers: vbox, hbox, box, layer

`vbox` stacks children vertically, `hbox` horizontally, `box` is
a generic container whose direction is set via the `direction` prop.
`layer` stacks all children on top of each other (see Layer section
below).

    render
      vbox padding: 20, gap: 12
        label text: "Header" end
        hbox gap: 8
          button text: "OK", on_click: HandleOK end
          button text: "Cancel", on_click: HandleCancel end
        end
      end
    end

Sidebar + main content using flex:

    hbox flex: 1
      vbox width: 200, padding: 8, background: "surface"
        label text: "Sidebar" end
      end
      vbox flex: 1, padding: 16
        label text: "Main content fills remaining space" end
      end
    end

No specific properties beyond the common set. Use padding, gap,
flex, justify, align, direction, background, etc.

---

### Layer

A stacking container where all children occupy the same position,
painted in order (first child is the background, last child is the
foreground). Unlike vbox/hbox which arrange children sequentially,
layer overlaps them.

    // Image with text overlay
    layer flex: 1
      image src: "photos/banner.png" end
      vbox padding: 16, justify: "end"
        label text: "Welcome", font_size: 24,
          foreground: "on_primary", font_weight: "bold"
        end
      end
    end

    // Loading overlay on top of content
    layer flex: 1
      // Normal content (painted first = background)
      vbox flex: 1
        table data: Items
          column field: "Name" end
          column field: "Price" end
        end
      end
      // Loading overlay (painted last = foreground)
      if IsLoading then
        vbox flex: 1, background: "overlay",
          justify: "center", align: "center"
          LoadingSpinner Size: 48 end
          label text: "Loading...", foreground: "on_primary" end
        end
      end
    end

    // Notification badge on an icon
    layer width: 32, height: 32
      icon name: "notification", size: 24 end
      if UnreadCount > 0 then
        label text: Str(UnreadCount),
          background: "danger", foreground: "on_danger",
          font_size: 10, padding: (1, 4),
          radius: 8, align: "start", justify: "end"
        end
      end
    end

All children are positioned at (0, 0) and sized to fill the layer's
content area. Use justify and align on child containers to position
content within the layer. No specific properties beyond the common
set.

---

### Label

Displays read-only text.

    label text: "Hello, World!" end
    label text: f"Count: {Count}", font_size: 20, foreground: "primary" end

No specific properties beyond the common set. Uses: text, font_size,
font_weight, foreground, text_align, wrap, overflow.

---

### Button

    button text: "Click Me", on_click: HandleClick end
    button text: "Delete", background: "danger", foreground: "on_danger",
      on_click: func() DeleteItem() end
    end
    button text: "Disabled", enabled: false end

No specific properties beyond the common set. Uses: text, enabled,
background, foreground, on_click.

---

### Separator and Spacer

Separator draws a thin line:

    vbox gap: 8
      label text: "Section 1" end
      separator end
      label text: "Section 2" end
    end

Spacer is an invisible flex element (defaults to flex: 1):

    hbox padding: 8
      label text: "Left" end
      spacer end
      label text: "Pushed right" end
    end

---

### TextInput

Single-line text entry.

    textinput value: Username, placeholder: "Enter username",
      on_change: func(V) Username := V end
    end
    textinput value: Password, mask: true,
      on_change: func(V) Password := V end,
      on_submit: func(V) HandleLogin() end
    end

**Important:** Without `on_change`, typing updates the display but
not the state. The next re-render reverts the text.

Uses common properties: value, placeholder, enabled, on_change,
on_submit. **Specific property:** `mask` (Boolean) -- when true,
shows asterisks instead of typed characters (password mode).

---

### Textarea

Multi-line editor with optional line numbers and monospace font.

    textarea value: Source, flex: 1, font: "mono",
      line_numbers: true, tab_size: 4,
      on_change: func(V) Source := V end
    end

    textarea value: Output, flex: 1, font: "mono",
      read_only: true, placeholder: "Output appears here..."
    end

**Specific properties:**

| Property | Type | Default | Description |
|---|---|---|---|
| line_numbers | Boolean | false | Show line number gutter |
| read_only | Boolean | false | Disable editing (selection still works) |
| tab_size | Integer | 4 | Spaces per Tab press |
| wrap | Boolean | false | Wrap long lines |
| font | String | "" | Font reference. Use "mono" for monospace |

Keyboard: Tab indents, Shift+Tab unindents, Ctrl+A selects all,
Home smart-homes, PgUp/PgDn scroll by page.

---

### NumericEdit

Numeric input with validation, spin buttons, and multi-base support.

    // Decimal quantity with range
    numericedit value: Quantity, min_value: 0, max_value: 100, step: 1,
      on_change: func(V) Quantity := V end
    end

    // Hexadecimal byte value
    numericedit value: HexVal, base: 16, min_value: 0, max_value: 255,
      min_digits: 2, on_change: func(V) HexVal := V end
    end

    // Currency with prefix and thousands separator
    numericedit value: Price, min_decimals: 2, max_decimals: 2,
      prefix: "$", thousands_separator: true,
      show_spin_buttons: true, step: 0.01,
      on_change: func(V) Price := V end
    end

**Specific properties:**

| Property | Type | Default | Description |
|---|---|---|---|
| value | Number | 0 | Current numeric value |
| base | Integer | 10 | Number base: 2, 8, 10, or 16 |
| min_digits | Integer | 0 | Minimum digits (zero-padded) |
| max_digits | Integer | 0 | Maximum digits (0 = unlimited) |
| min_decimals | Integer | 0 | Minimum decimal places |
| max_decimals | Integer | 0 | Maximum decimal places |
| allow_negative | Boolean | true | Allow negative values |
| allow_positive | Boolean | true | Allow positive values |
| min_value | Number | nil | Minimum allowed value |
| max_value | Number | nil | Maximum allowed value |
| step | Number | 1 | Spin button increment |
| prefix | String | "" | Text before number (e.g. "$") |
| suffix | String | "" | Text after number (e.g. "kg") |
| thousands_separator | Boolean | false | Show grouping (1,000) |
| use_locale_separator | Boolean | false | Use system locale separators |
| show_spin_buttons | Boolean | false | Show up/down buttons |
| text_align | String | "left" | "left", "center", "right" |
| output | String | "" | on_change output: "" (number) or "string" |

Events: on_change, on_error (func(errorMsg) for validation errors).

---

### Checkbox, Radio, Switch

    // State: IsDark := false, Size := "medium", Notify := true

    checkbox label: "Dark mode", checked: IsDark,
      on_change: func(V) IsDark := V end
    end

    radio label: "Small", group: "size", checked: Size = "small",
      on_change: func(V) if V then Size := "small" end end
    end
    radio label: "Medium", group: "size", checked: Size = "medium",
      on_change: func(V) if V then Size := "medium" end end
    end

    switch label: "Notifications", checked: Notify,
      on_change: func(V) Notify := V end
    end

**Checkbox specific:** `checked` (Boolean).
**Radio specific:** `checked` (Boolean), `group` (String -- radios with the same group are mutually exclusive).
**Switch specific:** `checked` (Boolean).

All three fire on_change with the new Boolean value.

---

### Select and Combobox

    // State: Country := "", CityOptions := ["Copenhagen", "Aarhus", "Odense"]

    select value: Country, placeholder: "Choose country",
      options: ["Denmark", "Germany", "Sweden", "Norway"],
      on_change: func(V) Country := V end
    end

    combobox value: City, options: CityOptions,
      on_change: func(V) City := V end
    end

Combobox adds type-to-filter as the user types.

**Specific properties:**

| Property | Type | Default | Description |
|---|---|---|---|
| options | Array | [] | Strings, or dicts with "key"/"value" for lookup mode |
| value | String | "" | Selected value (or key in lookup mode) |
| max_visible | Integer | 8 | Max items visible in dropdown |

When options are dicts like `[dict{"key": "dk", "value": "Denmark"}]`,
the dropdown shows `value` text but on_change returns `key`.

---

### Slider

    // State: Volume := 50

    slider value: Volume, min: 0, max: 100, step: 1,
      on_change: func(V) Volume := V end
    end

**Specific properties:**

| Property | Type | Default | Description |
|---|---|---|---|
| value | Number | 0 | Current position |
| min | Number | 0 | Minimum |
| max | Number | 100 | Maximum |
| step | Number | 1 | Increment |

---

### Progress

    progress value: 0.75 end
    progress value: DownloadProgress, max: 100 end
    progress indeterminate: true end

**Specific properties:**

| Property | Type | Default | Description |
|---|---|---|---|
| value | Number | 0 | Current progress |
| max | Number | 1.0 | Maximum (bar fills at value = max) |
| indeterminate | Boolean | false | Animated pulse instead of fixed fill |

---

### Icon

    icon name: "check", size: 24, color: "success" end
    icon name: "save", size: 16, color: "primary" end
    icon path: "M12 2L2 7l10 5 10-5-10-5z", size: 16 end

**Specific properties:**

| Property | Type | Default | Description |
|---|---|---|---|
| name | String | "" | Built-in icon name (see icon table above) |
| path | String | "" | Raw SVG path data (alternative to name) |
| viewbox | String | "" | SVG viewBox (e.g. "0 0 24 24") |
| size | Number | 16 | Icon size in pixels (sets width and height) |

---

### SVG

Renders full SVG markup with support for shapes, paths, transforms,
groups, reusable definitions, and SMIL animations.

    // State: Logo := "<svg viewBox='0 0 100 100'>
    //   <circle cx='50' cy='50' r='40' fill='blue'/></svg>"

    svg source: Logo, width: 200, height: 200 end

**Specific property:** `source` (String) -- full SVG markup string.
Also uses common width, height for display dimensions.

#### Supported SVG Elements

| Element | Description |
|---|---|
| `<svg>` | Root element with `viewBox` for coordinate mapping |
| `<g>` | Group with `transform` and `opacity` |
| `<path>` | Full path data (all SVG path commands) |
| `<rect>` | Rectangle: x, y, width, height, rx, ry (rounded) |
| `<circle>` | Circle: cx, cy, r |
| `<ellipse>` | Ellipse: cx, cy, rx, ry |
| `<line>` | Line: x1, y1, x2, y2 |
| `<polyline>` | Open connected points |
| `<polygon>` | Closed shape from points |
| `<use>` | Reference to defined element (xlink:href="#id") |
| `<symbol>` | Reusable definition (rendered via `<use>`) |
| `<defs>` | Definition container (not rendered directly) |
| `<text>` | Text label: x, y, font-family, font-size, font-weight, text-anchor |

#### SVG Path Commands

The `<path d="...">` supports the full command set (uppercase =
absolute, lowercase = relative): M (move), L (line), H (horizontal),
V (vertical), C (cubic bezier), S (smooth cubic), Q (quadratic
bezier), T (smooth quadratic), A (arc, simplified), Z (close).

#### SVG Attributes

fill, stroke, stroke-width, fill-opacity, stroke-opacity, opacity,
stroke-dasharray, transform, viewBox, display, visibility.

`currentColor` resolves to the widget's `foreground` color, so SVG
icons adapt to theme automatically.

#### SVG Transforms

translate(x,y), scale(sx,sy), rotate(deg), rotate(deg,cx,cy),
matrix(a,b,c,d,e,f), skewX(deg), skewY(deg). Multiple transforms
apply left to right.

#### SMIL Animations

SVG elements can contain `<animate>` and `<animateTransform>` child
elements for time-based animation at 60fps.

**Attribute animation** -- smoothly change any numeric attribute:

    // Pulsing circle: radius oscillates 20 to 40
    local Pulse := """
        <svg viewBox="0 0 100 100">
          <circle cx="50" cy="50" r="30" fill="#3498db">
            <animate attributeName="r"
              from="20" to="40" dur="1s"
              repeatCount="indefinite" />
          </circle>
        </svg>
        """
    svg source: Pulse, width: 100, height: 100 end

**Multi-keyframe animation** with `values` (semicolon-separated):

    // Color cycles red -> green -> blue -> red
    local Colors := """
        <svg viewBox="0 0 100 100">
          <rect x="10" y="10" width="80" height="80" rx="8">
            <animate attributeName="fill"
              values="#e74c3c;#27ae60;#3498db;#e74c3c"
              dur="3s" repeatCount="indefinite" />
          </rect>
        </svg>
        """

Numeric values interpolate smoothly between keyframes.
Non-numeric values (colors, strings) snap at the midpoint.

**Transform animation** -- animate rotate, scale, or translate:

    // Spinning loading indicator
    local Spinner := """
        <svg viewBox="0 0 50 50">
          <circle cx="25" cy="25" r="20"
            fill="none" stroke="currentColor"
            stroke-width="3" stroke-dasharray="80,50">
            <animateTransform attributeName="transform"
              type="rotate"
              from="0 25 25" to="360 25 25"
              dur="0.8s" repeatCount="indefinite" />
          </circle>
        </svg>
        """

The `type` attribute specifies: "rotate", "scale", or "translate".
Multi-component values (like "0 25 25" for angle and center) are
interpolated component-wise.

**Motion path animation** -- move an element along an SVG path:

    // Circle following a curved path
    local MotionDemo := """
        <svg viewBox="0 0 200 100">
          <path id="route" d="M10,50 C40,10 160,10 190,50"
            fill="none" stroke="#555" stroke-dasharray="4,4" />
          <circle r="6" fill="#3498db">
            <animateMotion dur="3s" repeatCount="indefinite">
              <mpath href="#route" />
            </animateMotion>
          </circle>
        </svg>
        """

`<animateMotion>` moves its parent element along a path. The path
can be specified inline via the `path` attribute or referenced via
a `<mpath href="#id" />` child element pointing to a `<path>` in
`<defs>`. The element is translated to each point along the path
over the animation duration. Supports the same timing attributes
as `<animate>`: dur, begin, repeatCount, fill.

**SVG text element:**

    local TextSvg := """
        <svg viewBox="0 0 200 60">
          <text x="100" y="35" fill="white"
            font-size="20" font-family="Segoe UI"
            text-anchor="middle">
            Hello, SVG!
          </text>
        </svg>
        """

The `<text>` element renders text at (x, y) coordinates. Attributes:
`font-family` (maps "monospace" to Cascadia Code), `font-size`,
`font-weight` ("bold"), `text-anchor` ("start", "middle", "end"
for horizontal alignment), `fill`, `fill-opacity`, `opacity`.
Child `<tspan>` content is concatenated into the text string.

**SMIL attributes:**

| Attribute | Description |
|---|---|
| attributeName | SVG attribute to animate (e.g. "r", "fill", "opacity", "cx") |
| from / to | Start and end values |
| values | Semicolon-separated keyframes (alternative to from/to) |
| dur | Duration: "1s", "500ms", "0.5s" |
| begin | Start delay: "0s", "2s" |
| repeatCount | Repetitions, or "indefinite" for forever |
| fill | After completion: "freeze" (hold) or "remove" (revert) |
| type | For animateTransform: "rotate", "scale", "translate" |

**Complete example -- reusable animated spinner component:**

    view LoadingSpinner
      props
        Size: default 48 Integer,
        Color: default "primary" String
      end
      render
        svg width: Size, height: Size, foreground: Color,
          source: f"""
            <svg viewBox="0 0 50 50">
              <circle cx="25" cy="25" r="20"
                fill="none" stroke="currentColor"
                stroke-width="3" stroke-dasharray="80,50"
                stroke-linecap="round">
                <animateTransform attributeName="transform"
                  type="rotate"
                  from="0 25 25" to="360 25 25"
                  dur="0.8s" repeatCount="indefinite" />
              </circle>
            </svg>
            """
        end
      end
    end

    // Usage:
    LoadingSpinner Size: 32, Color: "primary" end
    LoadingSpinner Size: 24, Color: "danger" end

---

### Image

    image src: "photos/logo.png", width: 200, height: 100 end

**Specific property:** `src` (String) -- file path to the image.
When no file is found, draws a placeholder outline. Also uses
common width, height for display dimensions.

---

### Scroll

Wraps content in a scrollable area with scrollbar. Mouse wheel
scrolling targets the scroll container under the cursor.

    // State: LogLines := ["Line 1", "Line 2", ..., "Line 200"]

    scroll direction: "vertical", flex: 1
      vbox gap: 4
        for I, Line in LogLines do
          label text: f"{I}: {Line}", key: f"line_{I}" end
        end
      end
    end

When `selectable` is true, the scroll container tracks which child
is selected (click to highlight), turning it into a basic selectable
list. For a full-featured list with item templates, use `listview`
instead.

**Specific properties:**

| Property | Type | Default | Description |
|---|---|---|---|
| selectable | Boolean | false | Enable child selection (click to highlight) |
| selected | Integer | -1 | Selected child index (when selectable is true) |
| multi_select | Boolean | false | Allow multiple selections (when selectable is true) |
| auto_scroll | Boolean | false | Automatically scroll to bottom when content grows (useful for log/chat views) |

Uses common `direction` ("vertical" or "horizontal") for scroll axis.

---

### Splitter

Resizable two-pane container. Accepts exactly 2 children.

    splitter direction: "horizontal", flex: 1
      vbox width: 200, min_width: 100
        label text: "File Browser" end
      end
      vbox flex: 1, min_width: 200
        label text: "Editor" end
      end
    end

Nested splitters create IDE layouts:

    splitter direction: "horizontal", flex: 1
      vbox width: 200
        // file tree
      end
      splitter direction: "vertical", flex: 1
        textarea value: Source, flex: 3, font: "mono" end
        textarea value: Output, flex: 1, font: "mono",
          read_only: true
        end
      end
    end

**Specific properties:**

| Property | Type | Default | Description |
|---|---|---|---|
| position | Number | -1 | Divider position in pixels. -1 auto-calculates from flex |
| min_pane | Number | 50 | Minimum pane size |
| handle_size | Number | 6 | Drag handle width |
| direction | String | "horizontal" | "horizontal" or "vertical" |

Event: `on_resize` -- `func(position)` called during drag.

---

### Tabs

    // State: ActiveTab := 0, IsDark := false

    tabs active: ActiveTab, on_change: func(V) ActiveTab := V end
      tab label: "Editor"
        textarea value: Source, flex: 1, font: "mono" end
      end
      tab label: "Preview"
        label text: "Preview content" end
      end
      tab label: "Settings"
        vbox padding: 16, gap: 8
          checkbox label: "Dark mode", checked: IsDark,
            on_change: func(V) IsDark := V end
          end
        end
      end
    end

**Specific properties:**

| Property | Type | Default | Description |
|---|---|---|---|
| active | Integer | 0 | Active tab index |
| closable | Boolean | false | Show close button on tabs |
| wrap | Boolean | false | Wrap tabs to multiple rows |
| placement | String | "top" | "top", "bottom", "left", "right" |
| vertical_text | Boolean | false | Rotate text (left/right placement) |
| rows | Integer | 0 | Force tab row count (0 = auto) |

Events: `on_change` -- `func(tabIndex)`, `on_close` -- `func(tabIndex)`.

---

### Menubar, Menu, MenuItem

    menubar
      menu label: "File"
        menuitem label: "New", shortcut: "Ctrl+N",
          on_click: HandleNew end
        menuitem label: "Open", shortcut: "Ctrl+O",
          on_click: HandleOpen end
        separator end
        menu label: "Recent Files"
          menuitem label: "file1.mc",
            on_click: func() OpenFile("file1.mc") end end
        end
        separator end
        menuitem label: "Exit", on_click: HandleExit end
      end
    end

MenuItem uses common properties: text/label, on_click, enabled,
checked (shows checkmark), shortcut (see Keyboard Shortcuts above --
displayed right-aligned in the menu as a visual hint).

### Popupmenu

A context menu triggered by right-click:

    // State: ShowPopup := false, PopupX := 0, PopupY := 0

    popupmenu visible: ShowPopup, popup_x: PopupX, popup_y: PopupY
      menuitem label: "Cut", on_click: HandleCut end
      menuitem label: "Copy", on_click: HandleCopy end
      menuitem label: "Paste", on_click: HandlePaste end
    end

**Specific properties:**

| Property | Type | Default | Description |
|---|---|---|---|
| visible | Boolean | false | Show/hide the popup |
| popup_x | Number | 0 | Horizontal position |
| popup_y | Number | 0 | Vertical position |

Event: `on_popup_close` -- called when dismissed.

---

### Toolbar and Statusbar

    toolbar
      button text: "New", on_click: HandleNew end
      button text: "Save", on_click: HandleSave end
      separator end
      button text: "Run", on_click: HandleRun end
      spacer end
      label text: "Ready", foreground: "text_muted" end
    end

    statusbar
      label text: StatusText, flex: 1 end
      separator end
      label text: f"Ln {Line}, Col {Col}" end
    end

No specific properties -- they use vbox/hbox layout with
theme-appropriate styling.

---

### Tree

    // State: SelectedFile := ""

    tree selected: SelectedFile,
      on_select: func(Item) SelectedFile := Item["path"] end
      treeitem label: "src", expanded: true
        treeitem label: "main.mc", icon: "file" end
        treeitem label: "utils.mc", icon: "file" end
      end
      treeitem label: "tests"
        treeitem label: "test1.mc", icon: "file" end
      end
    end

**Tree specific properties:**

| Property | Type | Default | Description |
|---|---|---|---|
| selected | Integer | -1 | Selected item index |
| row_height | Number | 24 | Row height |
| indent | Number | 20 | Indentation per nesting level |
| show_lines | Boolean | false | Connecting lines between nodes |
| show_icons | Boolean | true | Show expand/collapse icons |

**Treeitem specific:** `expanded` (Boolean) -- child visibility.

Tree uses `folder` and `file` icons by default for branch/leaf nodes.

---

### Table

Data grid with sorting, editing, grouping, and virtual scrolling.

**Minimal:**

    // State: Employees := [
    //   dict{ "Name": "Alice", "Age": 30, "Dept": "Engineering" },
    //   dict{ "Name": "Bob", "Age": 25, "Dept": "Marketing" }
    // ]

    table data: Employees
      column field: "Name", header: "Name" end
      column field: "Age", header: "Age" end
      column field: "Dept", header: "Department" end
    end

**Full example:**

    // State:
    //   Orders := [
    //     dict{ "OrderId": 1, "Customer": "Alice", "Total": 1250.00,
    //           "Status": "Shipped", "Flagged": false },
    //     dict{ "OrderId": 2, "Customer": "Bob", "Total": 890.50,
    //           "Status": "Pending", "Flagged": true }
    //   ],
    //   SortCol := "OrderId", SortDir := "asc", SelIdx := -1

    table data: Orders, editable: true,
      sort_by: SortCol, sort_dir: SortDir, auto_sort: true,
      selected: SelIdx, on_select: func(I) SelIdx := I end,
      striped: true, border: "grid",
      row_background: func(Row, RowIndex)
        if Row["Flagged"] then return "danger_dim" end
        return ""
      end

      column field: "OrderId", header: "ID", width: 80,
        align: "right", editable: false, sortable: true
      end
      column field: "Customer", header: "Customer", flex: 1,
        sortable: true
      end
      column header: "Total", field: "Total", width: 120,
        align: "right", editor: "number",
        foreground: func(Row)
          if Row["Total"] > 1000 then "danger" else "text" end
        end
        cell
          label text: f"${Row['Total']:,.2f}" end
        end
      end
      column header: "Status", width: 100, editor: "select",
        editor_options: ["Pending", "Shipped", "Cancelled"]
        cell
          label text: Row["Status"],
            foreground: if Row["Status"] = "Shipped" then "success" else "warning" end
          end
        end
      end
    end

**Table specific properties:**

| Property | Type | Default | Description |
|---|---|---|---|
| data | Array | required | Array of dicts |
| editable | Boolean | false | Enable cell editing |
| edit_mode | String | "cell" | "cell" or "row" |
| selected | Integer | -1 | Selected row |
| multi_select | Boolean | false | Multi-row selection |
| selection_mode | String | "single" | "single", "multi", "extended" |
| sort_by | String | "" | Sorted column field |
| sort_dir | String | "asc" | "asc" or "desc" |
| auto_sort | Boolean | false | Sort on header click |
| header_sort | Boolean | true | Allow header click sorting |
| default_sort_dir | String | "asc" | Initial sort direction for new column |
| auto_filter | Boolean | false | Enable column filtering |
| filter_shortcut | String | "" | Open filter keyboard shortcut |
| clear_filter_shortcut | String | "" | Clear filter shortcut |
| sort_shortcut | String | "" | Sort shortcut |
| search_shortcut | String | "" | Search shortcut |
| insert_shortcut | String | "" | Add row shortcut |
| row_height | Number | 32 | Row height |
| min_row_height | Number | 20 | Minimum (when row_resizable) |
| max_row_height | Number | 200 | Maximum (when row_resizable) |
| column_resizable | Boolean | true | Allow column resize drag |
| row_resizable | Boolean | false | Allow row resize drag |
| fixed_columns | Integer | 0 | Freeze first N columns |
| fixed_right | Integer | 0 | Freeze last N columns |
| fixed_rows | Integer | 0 | Freeze first N rows |
| striped | Boolean | false | Alternate row colors |
| border | String | "rows" | "none", "rows", "cols", "grid" |
| show_header | Boolean | true | Show header row |
| header_height | Number | auto | Custom header height |
| header_background | Color/Ref | "surface_dim" | Header background |
| header_foreground | Color/Ref | "" | Header text |
| selection_background | Color/Ref | "primary" | Selected row |
| selection_foreground | Color/Ref | "" | Selected text |
| hover_background | Color/Ref | "surface_dim" | Hovered row |
| grid_color | Color/Ref | "border" | Grid line color |
| empty_text | String | "No data" | Empty state message |
| group_by | String | "" | Grouping field |
| group_header_height | Number | 32 | Group header height |
| group_footer_height | Number | 32 | Group footer height |
| row_background | Callback | nil | func(Row, Index) -> color |
| row_foreground | Callback | nil | func(Row, Index) -> color |
| allow_add | Boolean | false | Show add-row UI |
| allow_delete | Boolean | false | Enable row deletion |

**Column properties:**

| Property | Type | Default | Description |
|---|---|---|---|
| field | String | "" | Dict key to display |
| header | String | field | Header text |
| width | Number | auto | Fixed width |
| flex | Number | 0 | Flex-grow |
| min_width | Number | 40 | Minimum width |
| align | String | "left" | "left", "center", "right" |
| sortable | Boolean | false | Click-to-sort |
| filterable | Boolean | false | Enable per-column filtering |
| editable | Boolean | inherit | Per-column edit control |
| editor | String | "text" | "text", "number", "boolean", "select" |
| editor_options | Array | nil | Options for select editor |
| foreground | Callback | nil | func(Row) -> color |

**Filtering and Searching:**

Tables have built-in filtering and searching that work without any
MIMERCode handler code. Set `auto_filter: true` on the table and
`filterable: true` on columns you want to filter:

    // State: Employees := [...], SortCol := "", SortDir := "asc"

    table data: Employees, auto_filter: true, auto_sort: true,
      sort_by: SortCol, sort_dir: SortDir

      column field: "Name", header: "Name", flex: 1,
        sortable: true, filterable: true
      end
      column field: "Dept", header: "Department", width: 150,
        sortable: true, filterable: true
      end
      column field: "Age", header: "Age", width: 80,
        align: "right", sortable: true
      end
    end

**Column filtering:** When a column has `filterable: true`, clicking
the column header shows a text input where you type a filter string.
Only rows whose cell text contains the filter string (case-insensitive)
are shown. Multiple columns can be filtered simultaneously -- they
combine with AND logic (all filters must match).

**Search bar:** A cross-column search that scans all cell text in
every row. The search bar appears below the header row and highlights
matching rows.

**Default keyboard shortcuts** (all customizable):

| Shortcut | Default | Description |
|---|---|---|
| filter_shortcut | Ctrl+F | Open filter input on focused/first filterable column |
| clear_filter_shortcut | Ctrl+Shift+F | Clear all filters and close search bar |
| search_shortcut | Ctrl+B | Toggle the cross-column search bar |
| sort_shortcut | Ctrl+S | Sort by focused column |
| insert_shortcut | Insert | Add new row (when allow_add is true) |

When search is open, press Enter to jump to the next matching row
(wraps around). Press the search shortcut again or Escape to close.

**Programmatic filter handling:** If you need custom filter logic
instead of the built-in text matching, omit `auto_filter` and handle
the `on_filter` event yourself:

    table data: FilteredEmployees,
      on_filter: func(Filters)
        // Filters is a dict: {"Name": "ali", "Dept": "eng"}
        // Apply your own filtering logic and update state
        FilteredEmployees := ApplyCustomFilter(AllEmployees, Filters)
      end
      ...
    end

**Custom cell templates:** `cell` block inside a column. `Row` and
`RowIndex` are implicit bindings:

    column header: "Actions", width: 120
      cell
        hbox gap: 4
          button text: "Edit",
            on_click: func() EditRow(RowIndex) end end
          button text: "Del", background: "danger",
            on_click: func() DeleteRow(RowIndex) end end
        end
      end
    end

**Table events:**

| Event | Callback | Description |
|---|---|---|
| on_select | func(index) | Row selection changed |
| on_sort | func(field, dir) | Header sort clicked |
| on_cell_edit | func(Row, Index, Field, Old, New) | Cell edited |
| on_row_edit | func(Row, Index) | Row edit completed |
| on_add | func() | Add row requested |
| on_delete | func(Row, Index) | Delete requested |
| on_confirm_delete | func(Row, Index) -> Bool | Confirm deletion |
| on_column_resize | func(colIndex, width) | Column resized |
| on_row_resize | func(rowIndex, height) | Row resized |
| on_filter | func(field, value) | Filter applied |

---

### ListView

Single-column scrollable list with templated items.

    // State:
    //   Messages := [
    //     dict{ "Sender": "Alice", "Subject": "Hello", "Date": "Mar 15" },
    //     dict{ "Sender": "Bob", "Subject": "Meeting", "Date": "Mar 14" }
    //   ],
    //   SelIdx := -1

    listview data: Messages, selected: SelIdx,
      on_select: func(I) SelIdx := I end

      template
        hbox padding: (8, 12), gap: 8
          label text: Row["Sender"], font_weight: "bold", width: 100 end
          label text: Row["Subject"], flex: 1 end
          label text: Row["Date"], foreground: "text_muted" end
        end
      end
    end

**Specific properties:**

| Property | Type | Default | Description |
|---|---|---|---|
| selected | Integer | -1 | Selected item index |
| multi_select | Boolean | false | Multi-selection |
| row_height | Number | 48 | Item height |
| divider | Boolean | true | Show separators |
| empty_text | String | "No data" | Empty state |
| selection_background | Color/Ref | "primary" | Selected highlight |
| selection_foreground | Color/Ref | "" | Selected text |
| hover_background | Color/Ref | "surface_dim" | Hovered item |
| divider_color | Color/Ref | "border" | Separator color |

Events: on_select, on_item_click, on_item_double_click.

---

### Chart

Data visualization: line, bar, area, pie, donut, scatter.

**Line chart:**

    // State: Sales := [
    //   dict{ "Month": "Jan", "Revenue": 12000 },
    //   dict{ "Month": "Feb", "Revenue": 15000 },
    //   dict{ "Month": "Mar", "Revenue": 13500 }
    // ]

    chart type: "line", data: Sales,
      x: "Month", y: "Revenue", title: "Revenue Trend"
    end

**Bar chart with multiple series** (y as array):

    // State: Report := [
    //   dict{ "Quarter": "Q1", "Revenue": 50000, "Cost": 30000, "Profit": 20000 },
    //   dict{ "Quarter": "Q2", "Revenue": 62000, "Cost": 35000, "Profit": 27000 }
    // ]

    chart type: "bar", data: Report,
      x: "Quarter", y: ["Revenue", "Cost", "Profit"],
      stacked: false, title: "Quarterly Results"
      y_axis label: "Amount ($)", format: "$,.0f", min: 0 end
      legend position: "top", interactive: true end
    end

**Pie/donut** (use label and value instead of x/y):

    // State: Share := [
    //   dict{ "Company": "Acme", "Share": 35 },
    //   dict{ "Company": "Other", "Share": 65 }
    // ]

    chart type: "donut", data: Share,
      label: "Company", value: "Share",
      show_percent: true, inner_radius: 0.55
    end

**Combo chart** (explicit series blocks, mixed types):

    chart type: "bar", data: Report, x: "Quarter"
      series field: "Revenue", color: "chart_1", type: "bar" end
      series field: "Profit", color: "chart_3", type: "line",
        dash: "4,4", marker: "circle"
      end
    end

**Chart specific properties:**

| Property | Type | Default | Description |
|---|---|---|---|
| data | Array | required | Array of dicts |
| type | String | required | "line", "bar", "area", "pie", "donut", "scatter", "map" |
| x | String | "" | X-axis field (cartesian) |
| y | String/Array | "" | Y-axis field(s). Array = multiple series |
| label | String | "" | Label field (pie/donut) |
| value | String | "" | Value field (pie/donut) |
| stacked | Boolean | false | Stack series |
| horizontal | Boolean | false | Horizontal bars |
| smooth | Boolean | false | Spline interpolation (line/area) |
| bar_width | Number | 0.8 | Bar width ratio |
| bar_radius | Number | 0 | Bar corner radius |
| inner_radius | Number | 0.6 | Donut hole ratio |
| start_angle | Number | -90 | Pie start angle (degrees) |
| sort_slices | Boolean | false | Sort pie by value |
| show_percent | Boolean | false | % labels on pie |
| show_values | Boolean | false | Value labels on points |
| center_text | String | "" | Donut center text |
| center_value | String | "" | Donut center value |
| title | String | "" | Chart title |
| title_font_size | Number | auto | Title font size |
| subtitle | String | "" | Subtitle |
| crosshair | String | "x" | "x", "y", "both", "none" |
| crosshair_color | Color/Ref | "" | Crosshair line color |
| crosshair_dash | String | "" | Crosshair dash (e.g. "4,4") |
| zoom | Boolean | false | Enable zoom |
| pan | Boolean | false | Enable pan |
| zoom_x | Boolean | true | Zoom X axis |
| zoom_y | Boolean | true | Zoom Y axis |
| animate | Boolean | false | Animate transitions |
| chart_background | Color/Ref | "" | Chart area background |
| chart_foreground | Color/Ref | "" | Chart text color |
| chart_border_color | Color/Ref | "" | Chart border |
| font_size | Number | auto | Base label font size |
| color_field | String | "" | Per-point color field (scatter) |
| size_field | String | "" | Per-point size field (scatter bubble) |
| marker_size | Number | 6 | Default marker size |
| hover_expand | Number | 0 | Hover expand for pie/scatter |
| chart_padding | Number/Tuple | auto | Chart area padding. Number, (v,h), or (top,right,bottom,left) |

**Chart events:**

| Event | Callback | Description |
|---|---|---|
| on_click | func(Point) | Point.X, Point.Value, Point.Series, Point.DataIndex |
| on_hover | func(Point) | nil when mouse leaves chart |
| on_zoom | func(Range) | Range.XMin, XMax, YMin, YMax |

---

### Map Chart

Choropleth geographic maps with drill-down navigation.

    // State:
    //   CurrentMap := "world", MapHistory := [],
    //   CountryGDP := [
    //     dict{ "Code": "US", "Name": "United States", "GDP": 21400000 },
    //     dict{ "Code": "CN", "Name": "China", "GDP": 14700000 },
    //     dict{ "Code": "DK", "Name": "Denmark", "GDP": 350000 }
    //   ]

    chart type: "map", data: CountryGDP,
      map: CurrentMap, region: "Code", value: "GDP",
      color_scale: "blue", title: "World GDP",
      on_click: func(Region)
        if Region.HasChildren then
          MapHistory := MapHistory + [CurrentMap]
          CurrentMap := Region.ChildMap
        end
      end,
      on_hover: func(Region)
        if Region <> nil then
          StatusText := f"{Region.Name}: ${Region.Value:,.0f}M"
        end
      end
    end

The `region` field must contain ISO codes matching the map file.

**Map-specific properties (in addition to chart properties):**

| Property | Type | Default | Description |
|---|---|---|---|
| map | String | required | Map ID ("world", "us-states", etc.) |
| region | String | required | Data field for region code |
| color_scale | String | "blue" | "blue", "red", "green", "orange", "diverging", "spectral", "categorical", or custom array |
| color_min | Number | auto | Scale minimum value |
| color_max | Number | auto | Scale maximum value |
| default_color | Color/Ref | "surface_dim" | Regions with no data |
| highlight_color | Color/Ref | "primary" | Hover highlight |
| border_color | Color/Ref | "" | Region border |
| show_labels | Boolean | false | Region name labels |
| drilldown | Boolean | false | Auto drill-down |
| map_background | Color/Ref | "" | Ocean/background |

**Map events:** on_click receives Region object with: Name, Code,
Value, HasChildren, ChildMap. on_hover receives Region (nil on leave).
on_drill fires on drill-down navigation.

**Map tools functions:**

    // Get metadata about an installed map
    local Info := map_info("world")
    WriteLn(Info["name"])          // "World"
    WriteLn(Info["projection"])    // "mercator"
    WriteLn(Info["region_count"])  // 177
    WriteLn(Info["bounds"])        // [-180, -85, 180, 85]
    // bounds array is compatible with geo_mercator()

    // List all installed .mcmap files
    local Maps := map_list()

| Function | Description |
|---|---|
| map_info(mapId) | Returns dict: id, name, projection, bounds (array), region_count |
| map_list() | List installed .mcmap files |
| map_import(geojson, id, options) | Convert GeoJSON to .mcmap with Douglas-Peucker simplification |
| map_save(json, filename) | Save .mcmap file |

---

### Control Flow in Render

**For loops** repeat UI. Always include `key`:

    // State: Items := ["Buy milk", "Walk dog", "Write code"]

    for I, Item in Items do
      hbox key: f"item_{I}", gap: 8
        label text: f"{I + 1}. {Item}" end
        button text: "Delete",
          on_click: func() RemoveItem(I) end
        end
      end
    end

**If/else** conditionally includes elements:

    if ErrorMsg <> "" then
      label text: ErrorMsg, foreground: "danger" end
    end

---

### Custom Views (Composability)

    view Badge
      props
        Text: required String,
        Color: default "primary" String
      end
      render
        label text: Text,
          background: f"{Color}_dim", foreground: Color,
          padding: (2, 8), radius: 4
        end
      end
    end

    hbox gap: 4
      Badge Text: "Admin", Color: "danger" end
      Badge Text: "Active", Color: "success" end
    end

---

### Navigation

For multi-screen apps, use `Navigate` inside view methods:

    func GoToDetail(Id: Integer)
      Navigate.Push("DetailView", dict{ "Id": Id })
    end
    func GoBack()
      Navigate.Pop()
    end
    func ShowDialog()
      Navigate.Show("ConfirmDialog", dict{
        "Message": "Are you sure?",
        "OnConfirm": func() DeleteItem() end
      })
    end

| Method | Description |
|---|---|
| Navigate.Push(view, props) | Push new view onto stack |
| Navigate.Pop() | Return to previous view |
| Navigate.Replace(view, props) | Replace current view |
| Navigate.Show(view, props) | Show modal overlay |
| Navigate.Dismiss() | Close top modal |
| Navigate.ClipboardGet() | Read system clipboard |
| Navigate.ClipboardSet(text) | Write to system clipboard |
---

# Part IX: For Experienced Developers

---

## Chapter 21: For Delphi Developers

| Delphi | MIMERCode | Why |
|---|---|---|
| begin...end; | Block ends with end | #1 LLM syntax error eliminated |
| Semicolons | None | Misplaced semicolons eliminated |
| function/procedure | func for both | Simpler, matches modern languages |
| Result := | return | Matches Python/JS/Rust |
| var block at top | local anywhere | Declare where you think |
| try/finally/Free | using X := create T() end | Automatic cleanup |
| 1-based strings | 0-based | Matches Python/JS/C |
| TDictionary verbose | dict{"k": v} | Matches Python/JS literals |
| TArray<T>.Create | [1, 2, 3] | Matches every modern language |

Everything else is familiar: class/record/interface, constructor/destructor/inherited, virtual/override/abstract, properties, try/except/finally, for/while/case, and/or/not, div/mod, const/type/enum.

---

## Chapter 22: For Python Developers and LLM Engineers

### Why MIMERCode Exists

MIMERCode exists for a specific scenario: **when an LLM needs to generate code that is safe, validated, and runs in a controlled environment.** Python is general-purpose where anything is possible, including deleting your hard drive. MIMERCode is purpose-built where the damage code can do is bounded by contracts and channels.

### Translation Guide

| Python | MIMERCode |
|---|---|
| x = 42 | local X := 42 |
| if x > 0: | if X > 0 then |
| for i in range(10): | for I in range(10) do |
| def foo(x): | func Foo(X: Integer) -> Integer |
| lambda x: x*2 | lambda(X: Integer) -> Integer return X*2 end |
| f"hello {name}" | f"hello {Name}" |
| x[1:3] | X[1:3] |
| d = {"k": v} | local D := dict{"k": V} |

### What Makes MIMERCode LLM-Friendly

1. **No ambiguous syntax.** Every block closes with end. No indentation sensitivity.
2. **Keywords are case-insensitive.** True/true/TRUE all work.
3. **F-strings identical to Python.** The most common string pattern LLMs produce.
4. **Contracts prevent silent data corruption.** Even if the LLM's logic is wrong, invalid data cannot pass through.
5. **Channels sandbox I/O.** Generated code cannot access resources you have not permitted.

### For LLM System Builders

If you build systems where an LLM generates code at runtime:

1. **Define contracts** for all data the LLM's code handles. They are your safety net.
2. **Use pipelines** for multi-step workflows. Per-step error handling means one bad step does not corrupt everything.
3. **Use channels** for all I/O. The sandbox ensures generated code cannot escape its permissions.
4. **Use config** for parameters. The LLM generates ConfigGet("api.key") instead of hardcoding secrets.

The combination means you can execute LLM-generated MIMERCode with confidence that invalid data is rejected, secrets never leak, I/O is sandboxed, every step has error handling, and execution is fully traceable.

---

# Appendices

---

## Appendix A: Complete Function Reference

### Core
WriteLn, Write, ReadLn, Inc, Dec, Length, High, Low, SetLength, Assigned, Sleep, Randomize

### Type Conversion
Str, String, int, float, bool, type, IntToStr, StrToInt, StrToIntDef, FloatToStr, StrToFloat

### String
Copy, Pos, Trim, UpperCase, LowerCase, StringReplace, Join, RepeatStr, PadLeft, PadRight, RegexMatch, RegexFind, RegexFindAll, RegexReplace, RegexSplit

### Math
Abs, Sqrt, Sqr, Power, Min, Max, Round, Trunc, Ceil, Floor, sign, clamp, hypot, fmod, copysign, near, sin, cos, tan, asin, acos, atan, atan2, degrees, radians, sinh, cosh, tanh, asinh, acosh, atanh, exp, exp2, log, log2, log10, isnan, isinf, isfinite, factorial, gcd, lcm, Random, randint, uniform, normal, choice, shuffle, seed, bitand, bitor, bitxor, bitnot, shl, shr

### Statistics
median, stdev, variance, percentile, corrcoef

### Array
repeat, fill, range, arange, filter, map, reduce, any, all, sorted, reversed, enumerate, zip, argsort, unique, cumsum, cumprod, diff, count

### Dictionary
get, haskey

### Date/Time
Now, NowUTC, ParseDate, ParseISO8601, ToISO8601, FormatDate, EncodeDate, EncodeDateTime, Year, Month, Day, Hour, Minute, Second, DayOfWeek, AddDays, AddHours, AddMinutes, AddSeconds, DateDiffDays, DateDiffSeconds, DateToStr, TimeToStr, DateTimeToUnix, UnixToDateTime

### Vector/Matrix
vector, matrix, tensor, zeros, ones, identity, diag, linspace, vadd, vsub, vmul, vscale, dot, cross, norm, normalize, mmul, transpose, trace, det, inv, solve, reshape, flatten, row, col, slice, sum, mean, vmin, vmax

### Config/Logging
ConfigLoad, ConfigLoadFile, ConfigMerge, ConfigGet, ConfigGetInt, ConfigGetFloat, ConfigGetBool, ConfigHas, ConfigSet, LogDebug, LogInfo, LogWarn, LogError, LogAudit, LogSetLevel, LogSetTraceId, LogNewTraceId

### Map Tools
map_import, map_save, map_list, map_info, http_get, file_write

### Data Formats
json_parse, json_stringify, csv_parse, csv_stringify

### Geographic
geo_distance, geo_bearing, geo_destination, geo_midpoint, geo_interpolate, geo_great_circle, geo_mercator, geo_mercator_inv, geo_contains, geo_area, geo_centroid, geo_bounds, geo_km_to_miles, geo_miles_to_km, geo_dms

### Version Introspection
MimerCodeVersion, MimerCodeVersionFull, MimerCodeBuildDate, MimerCodeFeatures, MimerCodeHasFeature

---

## Appendix B: Operator Reference

| Operator | Description |
|---|---|
| + - * / | Arithmetic |
| div mod | Integer division, remainder |
| = <> < > <= >= | Comparison |
| ~= ~<> | Approximate float comparison |
| and or not xor | Logical (short-circuit) |
| shl shr | Bitwise shift |
| := += -= *= | Assignment |
| ?? | Nil coalescing |
| \|> | Pipe operator |
| @ | Matrix multiplication |
| in | Membership test |
| is as | Type test / cast |
| matches | Regex match |
| [start:end] | Slice |
| if C then A else B end | Conditional expression |

---

## Appendix C: Keyword Reference

| Keywords | Purpose |
|---|---|
| program, unit, library, uses | Structure |
| func, return, end | Functions |
| local, var, const, type, enum | Declarations |
| if, then, elif, else | Conditionals |
| while, do, for, to, downto, in | Loops |
| repeat, until, break, continue | Loop control |
| case, of, epsilon | Case statement |
| try, except, finally, raise, on, assert | Errors |
| class, record, interface, field, prop | OOP |
| constructor, destructor, inherited | Lifecycle |
| create, free, using | Object management |
| virtual, override, abstract, static | Modifiers |
| private, protected, public | Visibility |
| lambda | Anonymous functions |
| contract, required, optional, sensitive | Contracts |
| pipeline, input, output, fork, route, when | Pipelines |
| open, serve, close | Channels |
| view, props, state, render | GUI |
| and, or, not, xor, div, mod | Operators |
| is, as, cast, matches, into | Type/pattern |
| true, false, nil, dict | Literals |
