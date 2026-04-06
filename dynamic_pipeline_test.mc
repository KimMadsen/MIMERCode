// dynamic_pipeline_test.mc - Test dynamic pipeline construction
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

contract DeliveryPackage
  OrderId: required Integer,
  Document: required String
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

func Assemble(H as Html, P as Pdf) as DeliveryPackage
  return DeliveryPackage {
    OrderId: 1,
    Document: f"{H.Value} + {P.Value}"
  }
end

// === Test 1: Basic dynamic pipeline ===
WriteLn("=== Test 1: Basic dynamic pipeline ===")

local P := CreatePipeline("OrderData", "Pdf")
P := PipelineAdd(P, "V", "ValidateOrder", "Input")
P := PipelineAdd(P, "H", "RenderOrder", "V")
P := PipelineAdd(P, "P", "HtmlToPdf", "H")

local Runner := PipelineRun(P)
local Order := OrderData { OrderId: 42, Total: 199.99 }
local R1 := Runner(Order)
WriteLn(f"Result: {R1.Value}")

// === Test 2: Dynamic pipeline with validation ===
WriteLn("=== Test 2: Validate ===")

local P2 := CreatePipeline("OrderData", "Pdf")
P2 := PipelineAdd(P2, "V", "ValidateOrder", "Input")
P2 := PipelineAdd(P2, "H", "RenderOrder", "V")
P2 := PipelineAdd(P2, "P", "HtmlToPdf", "H")

local Valid := PipelineValidate(P2)
WriteLn(f"Valid: {Valid}")

// === Test 3: Dynamic pipeline with error policy ===
WriteLn("=== Test 3: Error policy ===")

func FailStep(Input as OrderData) as OrderData
  raise Exception.Create("Failed")
  return Input
end

local P3 := CreatePipeline("OrderData", "Pdf")
P3 := PipelineAdd(P3, "V", "ValidateOrder", "Input")
P3 := PipelineAdd(P3, "F", "FailStep", "V", "skip")
P3 := PipelineAdd(P3, "H", "RenderOrder", "V")
P3 := PipelineAdd(P3, "P", "HtmlToPdf", "H")

local Runner3 := PipelineRun(P3)
local R3 := Runner3(Order)
WriteLn(f"Result: {R3.Value}")

// === Test 4: Multi-input merge ===
WriteLn("=== Test 4: Multi-input merge ===")

local P4 := CreatePipeline("OrderData", "DeliveryPackage")
P4 := PipelineAdd(P4, "V", "ValidateOrder", "Input")
P4 := PipelineAdd(P4, "H", "RenderOrder", "V")
P4 := PipelineAdd(P4, "P", "HtmlToPdf", "H")
P4 := PipelineAdd(P4, "D", "Assemble", ["H", "P"])

local Runner4 := PipelineRun(P4)
local R4 := Runner4(Order)
WriteLn(f"Result: {R4.Document}")

// === Test 5: Dynamic fork ===
WriteLn("=== Test 5: Dynamic fork ===")

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

local P5 := CreatePipeline("OrderData", "DeliveryPackage2")
P5 := PipelineAdd(P5, "V", "ValidateOrder", "Input")
P5 := PipelineFork(P5, "V", ["Customer", "Doc"], ["EnrichCustomer", "RenderOrder"])
// Note: Doc gets Html from RenderOrder, need HtmlToPdf step after
P5 := PipelineAdd(P5, "DocPdf", "HtmlToPdf", "Doc")
P5 := PipelineAdd(P5, "D", "Assemble2", ["Customer", "DocPdf"])
local Runner5 := PipelineRun(P5)
local R5 := Runner5(Order)
WriteLn(f"Fork result: {R5.CustomerName} - {R5.Document}")

// === Test 6: Dynamic route ===
WriteLn("=== Test 6: Dynamic route ===")

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

local P6 := CreatePipeline("OrderData", "ProcessedOrder")
P6 := PipelineAdd(P6, "V", "ValidateOrder", "Input")
P6 := PipelineRoute(P6, "Result", "V", "Priority", [">=3", "<3"], ["ExpressProcess", "StandardProcess"], "DefaultProcess")
local Runner6 := PipelineRun(P6)

local HighOrder := OrderData { OrderId: 99, Total: 500.0, Priority: 4 }
local R6 := Runner6(HighOrder)
WriteLn(f"Route high: {R6.Handler}")

local LowOrder := OrderData { OrderId: 100, Total: 200.0, Priority: 1 }
local R7 := Runner6(LowOrder)
WriteLn(f"Route low: {R7.Handler}")

WriteLn("=== All dynamic_pipeline tests passed ===")
