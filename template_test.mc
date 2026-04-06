// template_test.mc - Test template rendering (Mustache subset)
// Copyright 2026 Components4Developers - Kim Bo Madsen

// === Test 1: Basic interpolation with dict ===
WriteLn("=== Test 1: Basic interpolation ===")
local Data := dict{'Name': 'Kim', 'City': 'Aarhus'}
local Result := render(Data, "Hello {{Name}} from {{City}}!")
WriteLn(Result)
// Expected: Hello Kim from Aarhus!

// === Test 2: Conditional (truthy/falsy) ===
WriteLn("=== Test 2: Conditional ===")
local Tmpl := "{{#if Premium}}VIP: {{Name}}{{else}}{{Name}}{{/if}}"
local Vip := render(dict{'Name': 'Kim', 'Premium': true}, Tmpl)
local Reg := render(dict{'Name': 'Bob', 'Premium': false}, Tmpl)
WriteLn(Vip)
WriteLn(Reg)
// Expected: VIP: Kim
// Expected: Bob

// === Test 3: Iteration with #each ===
WriteLn("=== Test 3: Iteration ===")
local Invoice := dict{
  'Customer': 'Acme',
  'Items': [
    dict{'Name': 'Widget', 'Price': 4.99},
    dict{'Name': 'Gadget', 'Price': 12.50}
  ]
}
local InvTmpl := "Invoice for {{Customer}}\n{{#each Items}}  {{@index}}: {{Name}} - {{Price}}\n{{/each}}"
WriteLn(render(Invoice, InvTmpl, "text"))

// === Test 4: HTML escaping (default) ===
WriteLn("=== Test 4: HTML escaping ===")
local Unsafe := dict{'Content': "<script>alert('xss')</script>"}
WriteLn(render(Unsafe, "{{Content}}"))
// Expected: &lt;script&gt;alert(&#x27;xss&#x27;)&lt;/script&gt;

// === Test 5: Raw interpolation (no escaping) ===
WriteLn("=== Test 5: Raw interpolation ===")
WriteLn(render(Unsafe, "{{{Content}}}"))
// Expected: <script>alert('xss')</script>

// === Test 6: Text mode (no escaping) ===
WriteLn("=== Test 6: Text mode ===")
WriteLn(render(Unsafe, "{{Content}}", "text"))
// Expected: <script>alert('xss')</script>

// === Test 7: Contract instance data ===
WriteLn("=== Test 7: Contract data ===")

contract OrderData
  OrderId: required Integer,
  Total: required Double gte(0)
end

local Order := OrderData { OrderId: 42, Total: 199.99 }
WriteLn(render(Order, "Order #{{OrderId}}: Total {{Total}}", "text"))

// === Test 8: Sensitive field masking ===
WriteLn("=== Test 8: Sensitive masking ===")

contract PaymentInfo
  CardNumber: required String sensitive,
  Amount: required Double
end

local Pay := PaymentInfo { CardNumber: "4111-1111-1111-1111", Amount: 99.50 }
WriteLn(render(Pay, "Card: {{CardNumber}}, Amount: {{Amount}}", "text"))
// Expected: Card: ****, Amount: 99.5

// === Test 9: Nested field access ===
WriteLn("=== Test 9: Nested fields ===")
local Nested := dict{'Customer': dict{'Name': 'Kim', 'City': 'Aarhus'}, 'Total': 100}
WriteLn(render(Nested, "{{Customer.Name}} in {{Customer.City}}: {{Total}}", "text"))

// === Test 10: Comments ===
WriteLn("=== Test 10: Comments ===")
WriteLn(render(dict{'X': 'hello'}, "before{{! this is a comment }}after: {{X}}", "text"))
// Expected: beforeafter: hello

// === Test 11: Format specifier ===
WriteLn("=== Test 11: Format specifier ===")
WriteLn(render(dict{'Price': 42.5}, "Price: {{Price:%.2f}}", "text"))
// Expected: Price: 42.50

WriteLn("=== All template_test tests passed ===")
