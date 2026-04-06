// config_pipeline_test.mc - Test config-driven pipelines
// Copyright 2026 Components4Developers - Kim Bo Madsen

// === Define contracts and functions ===

contract OrderData
  OrderId: required Integer,
  Total: required Double gte(0),
  Priority: default 0 Integer range(0, 5)
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

// === Test 1: LoadPipeline from inline JSON ===
WriteLn("=== Test 1: LoadPipeline from JSON string ===")

local InlineP := LoadPipeline("InlineTest", '{"input": "OrderData", "output": "Pdf", "steps": [{"name": "V", "func": "ValidateOrder", "input": "Input"}, {"name": "H", "func": "RenderOrder", "input": "V"}, {"name": "P", "func": "HtmlToPdf", "input": "H"}], "return": "P"}')

local Order := OrderData { OrderId: 42, Total: 199.99 }
local R1 := InlineP(Order)
WriteLn(f"Result: {R1.Value}")

// === Test 2: LoadPipeline from Config ===
WriteLn("=== Test 2: LoadPipeline from Config ===")

ConfigLoad('{"pipelines": {"DocPipeline": {"input": "OrderData", "output": "Pdf", "steps": [{"name": "Validated", "func": "ValidateOrder", "input": "Input"}, {"name": "Html", "func": "RenderOrder", "input": "Validated"}, {"name": "Result", "func": "HtmlToPdf", "input": "Html"}]}}}')

local ConfigP := LoadPipeline("DocPipeline")
local R2 := ConfigP(Order)
WriteLn(f"Result: {R2.Value}")

// === Test 3: Pipeline with error policy ===
WriteLn("=== Test 3: Pipeline with on_error skip ===")

func FailStep(Input as OrderData) as OrderData
  raise Exception.Create("Step failed")
  return Input
end

local SkipP := LoadPipeline("SkipTest", '{"input": "OrderData", "output": "Pdf", "steps": [{"name": "V", "func": "ValidateOrder", "input": "Input"}, {"name": "F", "func": "FailStep", "input": "V", "on_error": "skip"}, {"name": "H", "func": "RenderOrder", "input": "V"}, {"name": "P", "func": "HtmlToPdf", "input": "H"}], "return": "P"}')

// Note: FailStep is skipped, rest of pipeline still completes
local R3 := SkipP(Order)
WriteLn(f"Result: {R3.Value}")

// === Test 4: Multi-input step ===
WriteLn("=== Test 4: Multi-input merge step ===")

contract DeliveryPackage
  OrderId: required Integer,
  Document: required String
end

func Assemble(H as Html, P as Pdf) as DeliveryPackage
  return DeliveryPackage {
    OrderId: 1,
    Document: f"{H.Value} + {P.Value}"
  }
end

local MergeP := LoadPipeline("MergeTest", '{"input": "OrderData", "output": "DeliveryPackage", "steps": [{"name": "V", "func": "ValidateOrder", "input": "Input"}, {"name": "H", "func": "RenderOrder", "input": "V"}, {"name": "P", "func": "HtmlToPdf", "input": "H"}, {"name": "D", "func": "Assemble", "input": ["H", "P"]}], "return": "D"}')

local R4 := MergeP(Order)
WriteLn(f"Result: {R4.Document}")

// === Test 5: Observability with config-loaded pipeline ===
WriteLn("=== Test 5: Observability ===")

ConfigLoad('{"pipelines": {"logging": true, "timing": true, "tracing": true, "ObsPipeline": {"input": "OrderData", "output": "Pdf", "steps": [{"name": "V", "func": "ValidateOrder", "input": "Input"}, {"name": "R", "func": "RenderOrder", "input": "V"}, {"name": "P", "func": "HtmlToPdf", "input": "R"}]}}}')

LogSetLevel("debug")
local ObsP := LoadPipeline("ObsPipeline")
local R5 := ObsP(Order)
WriteLn(f"Result: {R5.Value}")

// === Test 6: Config-driven fork ===
WriteLn("=== Test 6: Config-driven fork ===")

contract CustomerInfo
  CustomerId: required Integer,
  Name: required String
end

contract DeliveryPackage2
  CustomerName: required String,
  Document: required String
end

func EnrichCustomer(Input as OrderData) as CustomerInfo
  return CustomerInfo {
    CustomerId: Input.OrderId * 10,
    Name: f"Customer-{Input.OrderId}"
  }
end

func Assemble2(C as CustomerInfo, P as Pdf) as DeliveryPackage2
  return DeliveryPackage2 {
    CustomerName: C.Name,
    Document: P.Value
  }
end

LogSetLevel("warn")
local ForkP := LoadPipeline("ForkTest", '{"input": "OrderData", "output": "DeliveryPackage2", "steps": [{"name": "V", "func": "ValidateOrder", "input": "Input"}, {"name": "Parallel", "fork": {"input": "V", "branches": [{"name": "Customer", "func": "EnrichCustomer"}, {"name": "Doc", "chain": [{"func": "RenderOrder"}, {"func": "HtmlToPdf"}]}]}}, {"name": "Result", "func": "Assemble2", "input": ["Customer", "Doc"]}], "return": "Result"}')

local R6 := ForkP(Order)
WriteLn(f"Fork result: {R6.CustomerName} - {R6.Document}")

// === Test 7: Config-driven route ===
WriteLn("=== Test 7: Config-driven route ===")

contract ProcessedOrder
  OrderId: required Integer,
  Handler: required String
end

func ExpressProcess(Input as OrderData) as ProcessedOrder
  return ProcessedOrder { OrderId: Input.OrderId, Handler: "express" }
end

func StandardProcess(Input as OrderData) as ProcessedOrder
  return ProcessedOrder { OrderId: Input.OrderId, Handler: "standard" }
end

func DefaultProcess(Input as OrderData) as ProcessedOrder
  return ProcessedOrder { OrderId: Input.OrderId, Handler: "default" }
end

local RouteP := LoadPipeline("RouteTest", '{"input": "OrderData", "output": "ProcessedOrder", "steps": [{"name": "V", "func": "ValidateOrder", "input": "Input"}, {"name": "Result", "route": {"input": "V", "field": "Priority", "branches": [{"when": ">=3", "func": "ExpressProcess"}, {"when": "<3", "func": "StandardProcess"}], "else": "DefaultProcess"}}], "return": "Result"}')

// Test with high priority
local HighPri := OrderData { OrderId: 99, Total: 500.0, Priority: 4 }
local R7 := RouteP(HighPri)
WriteLn(f"Route high pri: {R7.Handler}")

// Test with low priority
local LowPri := OrderData { OrderId: 100, Total: 200.0, Priority: 1 }
local R8 := RouteP(LowPri)
WriteLn(f"Route low pri: {R8.Handler}")

WriteLn("=== All config_pipeline tests passed ===")
