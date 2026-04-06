// route_test.mc - Test conditional routing in pipelines
// Copyright 2026 Components4Developers - Kim Bo Madsen

// === Define contracts ===

contract OrderData
  OrderId: required Integer,
  Total: required Double gte(0),
  Priority: default 0 Integer range(0, 5),
  Region: default "US" String
end

contract ProcessedOrder
  OrderId: required Integer,
  Status: required String,
  Handler: required String
end

// === Define branch functions ===

func ValidateOrder(Input as OrderData) as OrderData
  assert Input.Total > 0, "Total must be positive"
  return Input
end

func ExpressProcess(Input as OrderData) as ProcessedOrder
  return ProcessedOrder {
    OrderId: Input.OrderId,
    Status: "express",
    Handler: "express-lane"
  }
end

func EuComplianceProcess(Input as OrderData) as ProcessedOrder
  return ProcessedOrder {
    OrderId: Input.OrderId,
    Status: "eu-compliant",
    Handler: "eu-compliance"
  }
end

func StandardProcess(Input as OrderData) as ProcessedOrder
  return ProcessedOrder {
    OrderId: Input.OrderId,
    Status: "standard",
    Handler: "standard-queue"
  }
end

// === Test 1: Route matches first when branch (Priority) ===
WriteLn("=== Test 1: High priority route ===")

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

local HighPri := OrderData { OrderId: 1, Total: 500.0, Priority: 4, Region: "US" }
local R1 := ProcessOrder(HighPri)
WriteLn(f"Order {R1.OrderId}: {R1.Status} via {R1.Handler}")

// === Test 2: Route matches second when branch (Region) ===
WriteLn("=== Test 2: EU compliance route ===")

local EuOrder := OrderData { OrderId: 2, Total: 200.0, Priority: 1, Region: "EU" }
local R2 := ProcessOrder(EuOrder)
WriteLn(f"Order {R2.OrderId}: {R2.Status} via {R2.Handler}")

// === Test 3: Route falls through to else ===
WriteLn("=== Test 3: Standard route (else) ===")

local StdOrder := OrderData { OrderId: 3, Total: 100.0, Priority: 1, Region: "US" }
local R3 := ProcessOrder(StdOrder)
WriteLn(f"Order {R3.OrderId}: {R3.Status} via {R3.Handler}")

// === Test 4: Route with high priority AND EU (first match wins) ===
WriteLn("=== Test 4: Priority wins over region ===")

local Both := OrderData { OrderId: 4, Total: 300.0, Priority: 5, Region: "EU" }
local R4 := ProcessOrder(Both)
WriteLn(f"Order {R4.OrderId}: {R4.Status} via {R4.Handler}")

WriteLn("=== All route_test tests passed ===")
