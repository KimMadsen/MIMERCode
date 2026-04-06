// fork_test.mc - Test fork (parallel branch execution in pipelines)
// Copyright 2026 Components4Developers - Kim Bo Madsen

// === Define contracts ===

contract OrderData
  OrderId: required Integer,
  Total: required Double gte(0)
end

contract CustomerInfo
  CustomerId: required Integer,
  Name: required String
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
  CustomerName: required String,
  Document: required String
end

// === Define contract-bound functions ===

func ValidateOrder(Input as OrderData) as OrderData
  assert Input.Total > 0, "Total must be positive"
  return Input
end

func EnrichCustomer(Input as OrderData) as CustomerInfo
  // Simulate customer lookup
  return CustomerInfo {
    CustomerId: Input.OrderId * 10,
    Name: f"Customer-{Input.OrderId}"
  }
end

func RenderOrder(Input as OrderData) as Html
  return Html { Value: f"<h1>Order {Input.OrderId}</h1>" }
end

func HtmlToPdf(Input as Html) as Pdf
  return Pdf { Value: f"[PDF:{Input.Value}]", PageCount: 1 }
end

func Assemble(C as CustomerInfo, D as Pdf) as DeliveryPackage
  return DeliveryPackage {
    OrderId: C.CustomerId,
    CustomerName: C.Name,
    Document: D.Value
  }
end

// === Test 1: Fork with multi-target destructuring ===
WriteLn("=== Test 1: Fork with destructuring ===")

pipeline InvoiceProcess
  input as OrderData
  output as DeliveryPackage

  Validated := ValidateOrder(Input)

  Customer, Doc := fork Validated
    => EnrichCustomer()
    => RenderOrder() |> HtmlToPdf()
  end

  return Assemble(Customer, Doc)
end

local Order := OrderData { OrderId: 42, Total: 199.99 }
local Package := InvoiceProcess(Order)
WriteLn(f"Order: {Package.OrderId}")
WriteLn(f"Customer: {Package.CustomerName}")
WriteLn(f"Document: {Package.Document}")

// === Test 2: Sequential pipeline (same logic, no fork) ===
WriteLn("=== Test 2: Sequential pipeline ===")

pipeline InvoiceProcess2
  input as OrderData
  output as DeliveryPackage

  Validated := ValidateOrder(Input)
  Customer := EnrichCustomer(Validated)
  Doc := Validated |> RenderOrder() |> HtmlToPdf()
  return Assemble(Customer, Doc)
end

local Package2 := InvoiceProcess2(Order)
WriteLn(f"Order: {Package2.OrderId}")
WriteLn(f"Customer: {Package2.CustomerName}")
WriteLn(f"Document: {Package2.Document}")

WriteLn("=== All fork_test tests passed ===")
