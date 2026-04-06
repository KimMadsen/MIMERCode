// pipeline_test.mc - Test pipeline core (sequential execution with contract validation)
// Copyright 2026 Components4Developers - Kim Bo Madsen

// === Define contracts ===

contract OrderData
  OrderId: required Integer,
  Total: required Double gte(0)
end

contract Html
  Value: required String
end

contract Pdf
  Value: required String,
  PageCount: default 1 Integer
end

// === Define contract-bound functions ===

func ValidateOrder(Input as OrderData) as OrderData
  assert Input.Total > 0, "Total must be positive"
  return Input
end

func RenderOrder(Input as OrderData) as Html
  return Html { Value: f"<h1>Order {Input.OrderId}</h1>" }
end

func HtmlToPdf(Input as Html) as Pdf
  return Pdf { Value: f"[PDF:{Input.Value}]", PageCount: 1 }
end

// === Test 1: Basic pipeline ===
WriteLn("=== Test 1: Basic pipeline ===")

pipeline InvoiceExport
  input as OrderData
  output as Pdf

  Validated := ValidateOrder(Input)
  Html := RenderOrder(Validated)
  return HtmlToPdf(Html)
end

local Order := OrderData { OrderId: 42, Total: 199.99 }
local Result := InvoiceExport(Order)
WriteLn(f"Generated: {Result.Value}, pages: {Result.PageCount}")

// === Test 2: Pipeline with pipe chain in step ===
WriteLn("=== Test 2: Pipeline with pipe chain ===")

pipeline InvoiceExport2
  input as OrderData
  output as Pdf

  Validated := ValidateOrder(Input)
  return Validated |> RenderOrder() |> HtmlToPdf()
end

local Result2 := InvoiceExport2(Order)
WriteLn(f"Generated: {Result2.Value}, pages: {Result2.PageCount}")

// === Test 3: Pipeline input validation failure ===
WriteLn("=== Test 3: Input validation failure ===")

try
  local BadOrder := OrderData { OrderId: 99, Total: -10.0 }
  local Bad := InvoiceExport(BadOrder)
  WriteLn("ERROR: Should have thrown")
except on E: Exception do
  WriteLn(f"Caught: {E}")
end

// === Test 4: Pipeline with extra functions ===
WriteLn("=== Test 4: Pipeline with extra functions ===")

func AddTax(Input as OrderData) as OrderData
  return OrderData {
    OrderId: Input.OrderId,
    Total: Input.Total * 1.25
  }
end

pipeline TaxInvoice
  input as OrderData
  output as Pdf

  Taxed := AddTax(Input)
  Validated := ValidateOrder(Taxed)
  Html := RenderOrder(Validated)
  return HtmlToPdf(Html)
end

local Result4 := TaxInvoice(Order)
WriteLn(f"With tax: {Result4.Value}")

// === Test 5: Named arguments in function calls ===
WriteLn("=== Test 5: Named arguments ===")

func AddTaxRate(Input as OrderData, Rate: Double) as OrderData
  return OrderData {
    OrderId: Input.OrderId,
    Total: Input.Total * (1.0 + Rate)
  }
end

// Positional call
local R5a := AddTaxRate(Order, 0.25)
WriteLn(f"Positional: {R5a.Total}")

// Named argument call
local R5b := AddTaxRate(Order, Rate: 0.10)
WriteLn(f"Named: {R5b.Total}")

// === Test 6: Named arguments in pipe chain ===
WriteLn("=== Test 6: Named args in pipe ===")

local R6 := Order |> AddTaxRate(Rate: 0.20) |> RenderOrder()
WriteLn(f"Piped with named: {R6.Value}")

// === Test 7: Multiple named arguments ===
WriteLn("=== Test 7: Multiple named args ===")

func FormatInvoice(Input as OrderData, Title: String, Currency: String) as Html
  return Html { Value: f"{Title}: {Input.Total} {Currency}" }
end

local R7 := FormatInvoice(Order, Currency: "EUR", Title: "Invoice")
WriteLn(f"Multi-named: {R7.Value}")

WriteLn("=== All pipeline_test tests passed ===")
