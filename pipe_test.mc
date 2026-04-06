// pipe_test.mc - Test pipe operator |> with contract-bound functions
// Copyright 2026 Components4Developers - Kim Bo Madsen

// === Define contracts ===

contract OrderData
  OrderId: required Integer,
  Total: required Double gte(0)
end

contract Html
  Value: required String,
  Encoding: default "utf-8" String
end

// === Contract-bound functions for pipe chains ===

func ValidateOrder(Input as OrderData) as OrderData
  assert Input.Total > 0, "Total must be positive"
  return Input
end

func FormatOrder(Input as OrderData) as Html
  return Html {
    Value: f"<h1>Order {Input.OrderId}</h1><p>Total: {Input.Total}</p>"
  }
end

func Minify(Input as Html) as Html
  return Html {
    Value: StringReplace(Input.Value, "  ", ""),
    Encoding: Input.Encoding
  }
end

// === Test 1: Basic pipe chain ===
WriteLn("=== Test 1: Basic pipe chain ===")

local Order := OrderData { OrderId: 42, Total: 199.99 }
local Result := Order |> ValidateOrder() |> FormatOrder() |> Minify()
WriteLn(Result.Value)

// === Test 2: Pipe with extra arguments ===
WriteLn("=== Test 2: Pipe with extra arguments ===")

func AddTax(Input as OrderData, Rate: Double) as OrderData
  return OrderData {
    OrderId: Input.OrderId,
    Total: Input.Total * (1.0 + Rate)
  }
end

local WithTax := Order |> AddTax(0.25) |> FormatOrder()
WriteLn(WithTax.Value)

// === Test 3: Pipe with plain functions ===
WriteLn("=== Test 3: Pipe with plain functions ===")

func DoubleTotal(Input as OrderData) as OrderData
  return OrderData {
    OrderId: Input.OrderId,
    Total: Input.Total * 2
  }
end

local Doubled := Order |> DoubleTotal() |> ValidateOrder() |> FormatOrder()
WriteLn(Doubled.Value)

// === Test 4: Single pipe ===
WriteLn("=== Test 4: Single pipe ===")

local Simple := Order |> FormatOrder()
WriteLn(Simple.Value)

WriteLn("=== All pipe_test tests passed ===")
