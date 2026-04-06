// contract_func_test.mc - Test contract-bound function parameters and returns
// Copyright 2026 Components4Developers - Kim Bo Madsen

// === Define contracts ===

contract OrderData
  OrderId: required Integer,
  Total: required Double gte(0)
end

contract Result
  OrderId: required Integer,
  Status: required String
end

contract RushOrder : OrderData
  Priority: default 1 Integer range(1, 5)
end

// === Test 1: Basic contract-bound function ===
WriteLn("=== Test 1: Basic contract-bound function ===")

func ProcessOrder(Input as OrderData) as Result
  return Result {
    OrderId: Input.OrderId,
    Status: "processed"
  }
end

local R := ProcessOrder(OrderData { OrderId: 1, Total: 99.0 })
WriteLn(f"Order {R.OrderId}: {R.Status}")

// === Test 2: Validation on entry (should fail - negative total) ===
WriteLn("=== Test 2: Validation failure on entry ===")

try
  local Bad := ProcessOrder(OrderData { OrderId: 2, Total: -5.0 })
  WriteLn("ERROR: Should have thrown")
except on E: Exception do
  WriteLn(f"Caught: {E}")
end

// === Test 3: Mixed plain + contract params ===
WriteLn("=== Test 3: Mixed plain + contract params ===")

func BuildOrder(CustomerId: Integer, Items: Array) as OrderData
  return OrderData {
    OrderId: CustomerId * 100,
    Total: Length(Items) * 10.0
  }
end

local O := BuildOrder(42, ["item1", "item2"])
WriteLn(f"Built order {O.OrderId}, total {O.Total}")

// === Test 4: Contract inheritance (RushOrder accepted as OrderData) ===
WriteLn("=== Test 4: Contract inheritance ===")

local Rush := RushOrder { OrderId: 3, Total: 250.0, Priority: 4 }
local R2 := ProcessOrder(Rush)
WriteLn(f"Rush order {R2.OrderId}: {R2.Status}")

// === Test 5: Plain return type still works ===
WriteLn("=== Test 5: Plain return type ===")

func ExtractTotal(Input as OrderData) -> Double
  return Input.Total
end

local T := ExtractTotal(OrderData { OrderId: 10, Total: 42.5 })
WriteLn(f"Total: {T}")

WriteLn("=== All contract_func tests passed ===")
