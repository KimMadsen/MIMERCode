// MimerCode 'matches' Operator Test Suite
// Tests: regex match expression, matches into capture binding
// Copyright 2026 Components4Developers - Kim Bo Madsen
// Run with: MimerCodeRunner matches_test.mc

program MatchesTest

  WriteLn("=== 'matches' Operator Tests ===")
  WriteLn("")

  // -------------------------------------------------------
  // 1. Simple boolean test (no captures)
  // -------------------------------------------------------
  WriteLn("1. Simple boolean test:")

  local Text := "Hello World 123"

  if Text matches r"\d+" then
    WriteLn("  Contains digits: True")
  else
    WriteLn("  Contains digits: False")
  end

  if Text matches r"^[A-Z]" then
    WriteLn("  Starts with uppercase: True")
  else
    WriteLn("  Starts with uppercase: False")
  end

  if Text matches "xyz" then
    WriteLn("  Contains xyz: True")
  else
    WriteLn("  Contains xyz: False (correct)")
  end
  WriteLn("")

  // -------------------------------------------------------
  // 2. Expression form - returns array of capture groups
  // -------------------------------------------------------
  WriteLn("2. Expression form (returns array):")

  local ErrMsg := "Error 404: Not Found"
  local M := ErrMsg matches r"Error (\d+): (.+)"
  if M then
    WriteLn(f"  Full match: {M[0]}")
    WriteLn(f"  Error code: {M[1]}")
    WriteLn(f"  Message:    {M[2]}")
  else
    WriteLn("  No match")
  end
  WriteLn("")

  // -------------------------------------------------------
  // 3. Expression form - no match returns nil (falsy)
  // -------------------------------------------------------
  WriteLn("3. No match returns nil:")

  local M2 := "hello" matches r"(\d+)"
  if M2 then
    WriteLn("  Should not reach here")
  else
    WriteLn("  No match: M2 is nil/falsy (correct)")
  end
  WriteLn("")

  // -------------------------------------------------------
  // 4. matches ... into (capture binding)
  // -------------------------------------------------------
  WriteLn("4. matches into (capture binding):")

  local LogLine := "2025-03-15 14:30:22 [ERROR] Connection timeout"

  if LogLine matches r"(\d{4}-\d{2}-\d{2}) (\d{2}:\d{2}:\d{2}) \[(\w+)\] (.+)" into LDate, LTime, LLevel, LMsg then
    WriteLn(f"  Date:    {LDate}")
    WriteLn(f"  Time:    {LTime}")
    WriteLn(f"  Level:   {LLevel}")
    WriteLn(f"  Message: {LMsg}")
  else
    WriteLn("  No match")
  end
  WriteLn("")

  // -------------------------------------------------------
  // 5. matches into - no match (variables get empty strings)
  // -------------------------------------------------------
  WriteLn("5. matches into - no match:")

  if "hello world" matches r"(\d+)-(\d+)" into LA, LB then
    WriteLn("  Should not reach here")
  else
    WriteLn(f"  No match: LA='{LA}', LB='{LB}' (empty strings)")
  end
  WriteLn("")

  // -------------------------------------------------------
  // 6. Practical: parse structured data
  // -------------------------------------------------------
  WriteLn("6. Parse structured data:")

  local Lines := ["GET /api/users 200", "POST /api/login 401", "GET /index.html 304"]

  for Line in Lines do
    if Line matches r"(\w+) (\S+) (\d+)" into Method, Path, Status then
      WriteLn(f"  {Method} {Path} -> {Status}")
    end
  end
  WriteLn("")

  // -------------------------------------------------------
  // 7. Email validation
  // -------------------------------------------------------
  WriteLn("7. Email validation:")

  local Emails := ["alice@example.com", "not-an-email", "bob@test.org", "@invalid"]

  for Email in Emails do
    if Email matches r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" then
      WriteLn(f"  {Email} -> valid")
    else
      WriteLn(f"  {Email} -> invalid")
    end
  end
  WriteLn("")

  // -------------------------------------------------------
  // 8. Extract with expression form, process results
  // -------------------------------------------------------
  WriteLn("8. Extract and process:")

  local Version := "MimerCode v1.6.3-beta"
  local VM := Version matches r"v(\d+)\.(\d+)\.(\d+)"
  if VM then
    WriteLn(f"  Major: {VM[1]}")
    WriteLn(f"  Minor: {VM[2]}")
    WriteLn(f"  Patch: {VM[3]}")
    local VerNum := int(VM[1]) * 100 + int(VM[2]) * 10 + int(VM[3])
    WriteLn(f"  Version number: {VerNum}")
  end
  WriteLn("")

  // -------------------------------------------------------
  // 9. Combining matches with other features
  // -------------------------------------------------------
  WriteLn("9. Combined with Split:")

  local CSV := "Alice,30,Engineer;Bob,25,Designer;Charlie,35,Manager"
  local Records := CSV.Split(";")
  for Rec in Records do
    if Rec matches r"([^,]+),(\d+),(.+)" into Name, Age, Role then
      WriteLn(f"  {Name} (age {Age}): {Role}")
    end
  end
  WriteLn("")

  // -------------------------------------------------------
  // 10. Matches as expression in assignment
  // -------------------------------------------------------
  WriteLn("10. Matches in variable assignment:")

  local IP := "192.168.1.100"
  local Parts := IP matches r"(\d+)\.(\d+)\.(\d+)\.(\d+)"
  if Parts then
    WriteLn(f"  IP parts: {Parts[1]}.{Parts[2]}.{Parts[3]}.{Parts[4]}")
    WriteLn(f"  Octets: {Parts.Count - 1}")
  end
  WriteLn("")

  WriteLn("=== All 'matches' Tests Complete ===")

end
