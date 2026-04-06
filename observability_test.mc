// observability_test.mc - Test pipeline observability (logging, timing, tracing)
// Copyright 2026 Components4Developers - Kim Bo Madsen

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

// === Test 1: Pipeline with observability disabled (default) ===
WriteLn("=== Test 1: Observability disabled (default) ===")

pipeline QuietPipeline
  input as OrderData
  output as Pdf
  Validated := ValidateOrder(Input)
  Html := RenderOrder(Validated)
  return HtmlToPdf(Html)
end

local Order := OrderData { OrderId: 1, Total: 100.0 }
local R1 := QuietPipeline(Order)
WriteLn(f"Result: {R1.Value}")
WriteLn("(No log output expected above)")

// === Test 2: Enable logging and timing ===
WriteLn("=== Test 2: Logging and timing enabled ===")
ConfigLoad('{"pipelines": {"logging": true, "timing": true, "tracing": false}}')
LogSetLevel("debug")

pipeline LoggedPipeline
  input as OrderData
  output as Pdf
  Validated := ValidateOrder(Input)
  Html := RenderOrder(Validated)
  return HtmlToPdf(Html)
end

local R2 := LoggedPipeline(Order)
WriteLn(f"Result: {R2.Value}")

// === Test 3: Enable tracing ===
WriteLn("=== Test 3: With tracing ===")
ConfigLoad('{"pipelines": {"logging": true, "timing": true, "tracing": true}}')

pipeline TracedPipeline
  input as OrderData
  output as Pdf
  Validated := ValidateOrder(Input)
  Html := RenderOrder(Validated)
  return HtmlToPdf(Html)
end

local R3 := TracedPipeline(Order)
WriteLn(f"Result: {R3.Value}")

// === Test 4: Error logging ===
WriteLn("=== Test 4: Error logging ===")

func FailStep(Input as OrderData) as Html
  raise Exception.Create("Deliberate failure")
  return Html { Value: "never" }
end

pipeline FailingPipeline
  input as OrderData
  output as Pdf
  Html := FailStep(Input)
  return HtmlToPdf(Html)
end

try
  local R4 := FailingPipeline(Order)
except on E: Exception do
  WriteLn(f"Caught: {E}")
end

// === Test 5: Fork observability ===
WriteLn("=== Test 5: Fork with observability ===")

contract CustomerInfo
  CustomerId: required Integer,
  Name: required String
end

contract DeliveryPackage
  OrderId: required Integer,
  CustomerName: required String,
  Document: required String
end

func EnrichCustomer(Input as OrderData) as CustomerInfo
  return CustomerInfo {
    CustomerId: Input.OrderId * 10,
    Name: f"Customer-{Input.OrderId}"
  }
end

func Assemble(C as CustomerInfo, D as Pdf) as DeliveryPackage
  return DeliveryPackage {
    OrderId: C.CustomerId,
    CustomerName: C.Name,
    Document: D.Value
  }
end

pipeline ForkObsPipeline
  input as OrderData
  output as DeliveryPackage

  Validated := ValidateOrder(Input)

  Customer, Doc := fork Validated
    => EnrichCustomer()
    => RenderOrder() |> HtmlToPdf()
  end

  return Assemble(Customer, Doc)
end

local R5 := ForkObsPipeline(Order)
WriteLn(f"Result: {R5.CustomerName} - {R5.Document}")

WriteLn("=== All observability tests passed ===")
