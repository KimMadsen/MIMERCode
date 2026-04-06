// error_handling_test.mc - Test pipeline error handling policies
// Copyright 2026 Components4Developers - Kim Bo Madsen

contract OrderData
  OrderId: required Integer,
  Total: required Double gte(0)
end

contract Result
  OrderId: required Integer,
  Status: required String
end

// A function that always fails
func FailingStep(Input as OrderData) as Result
  raise Exception.Create("Step failed deliberately")
  return Result { OrderId: Input.OrderId, Status: "never reached" }
end

// A function that succeeds
func SucceedingStep(Input as OrderData) as Result
  return Result { OrderId: Input.OrderId, Status: "success" }
end

// A fallback function
func FallbackStep(Input as OrderData) as Result
  return Result { OrderId: Input.OrderId, Status: "fallback-used" }
end

// Counter to track retry attempts
local RetryCounter := 0

func RetryableStep(Input as OrderData) as Result
  RetryCounter += 1
  if RetryCounter < 3 then
    raise Exception.Create(f"Attempt {RetryCounter} failed")
  end
  return Result { OrderId: Input.OrderId, Status: f"succeeded-on-attempt-{RetryCounter}" }
end

// === Test 1: Default policy (abort) ===
WriteLn("=== Test 1: Abort (default) ===")

pipeline AbortPipeline
  input as OrderData
  output as Result
  Step := FailingStep(Input)
  return Step
end

try
  local Order := OrderData { OrderId: 1, Total: 100.0 }
  local R := AbortPipeline(Order)
  WriteLn("ERROR: Should have thrown")
except on E: Exception do
  WriteLn(f"Caught abort: {E}")
end

// === Test 2: Skip policy ===
WriteLn("=== Test 2: Skip ===")

pipeline SkipPipeline
  input as OrderData
  output as Result
  Skipped := FailingStep(Input)
    on error skip
  return SucceedingStep(Input)
end

local Order2 := OrderData { OrderId: 2, Total: 200.0 }
local R2 := SkipPipeline(Order2)
WriteLn(f"Skip result: {R2.Status}")

// === Test 3: Retry policy ===
WriteLn("=== Test 3: Retry ===")

RetryCounter := 0

pipeline RetryPipeline
  input as OrderData
  output as Result
  Step := RetryableStep(Input)
    on error retry(5)
  return Step
end

local Order3 := OrderData { OrderId: 3, Total: 300.0 }
local R3 := RetryPipeline(Order3)
WriteLn(f"Retry result: {R3.Status}")

// === Test 4: Retry exhausted ===
WriteLn("=== Test 4: Retry exhausted ===")

RetryCounter := 0

pipeline RetryExhaustedPipeline
  input as OrderData
  output as Result
  Step := FailingStep(Input)
    on error retry(2)
  return Step
end

try
  local Order4 := OrderData { OrderId: 4, Total: 400.0 }
  local R4 := RetryExhaustedPipeline(Order4)
  WriteLn("ERROR: Should have thrown")
except on E: Exception do
  WriteLn(f"Caught exhausted: {E}")
end

// === Test 5: Error policy on next line ===
WriteLn("=== Test 5: Error policy on next line ===")

pipeline NextLinePipeline
  input as OrderData
  output as Result
  Skipped := FailingStep(Input)
    on error skip
  return SucceedingStep(Input)
end

local Order5 := OrderData { OrderId: 5, Total: 500.0 }
local R5 := NextLinePipeline(Order5)
WriteLn(f"Next-line skip: {R5.Status}")

// === Test 6: Fallback function ===
WriteLn("=== Test 6: Fallback ===")

pipeline FallbackPipeline
  input as OrderData
  output as Result
  Step := FailingStep(Input)
    on error fallback FallbackStep()
  return Step
end

local Order6 := OrderData { OrderId: 6, Total: 600.0 }
local R6 := FallbackPipeline(Order6)
WriteLn(f"Fallback result: {R6.Status}")

WriteLn("=== All error_handling tests passed ===")
