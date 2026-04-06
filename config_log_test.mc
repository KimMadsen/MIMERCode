// config_log_test.mc - Test Config and Log systems
// Copyright 2026 Components4Developers - Kim Bo Madsen

// === Test 1: Load config from JSON string ===
WriteLn("=== Test 1: Config basics ===")
ConfigLoad('{"app": {"name": "MyApp", "port": 8080, "debug": true}, "version": "1.0"}')
WriteLn(f"App: {ConfigGet('app.name')}")
WriteLn(f"Port: {ConfigGetInt('app.port')}")
WriteLn(f"Debug: {ConfigGetBool('app.debug')}")
WriteLn(f"Version: {ConfigGet('version')}")

// === Test 2: Config defaults ===
WriteLn("=== Test 2: Config defaults ===")
WriteLn(f"Missing: '{ConfigGet('nonexistent', 'default_value')}'")
WriteLn(f"Missing int: {ConfigGetInt('nonexistent', 42)}")
WriteLn(f"Has app: {ConfigHas('app')}")
WriteLn(f"Has missing: {ConfigHas('nonexistent')}")

// === Test 3: Config merge ===
WriteLn("=== Test 3: Config merge ===")
ConfigMerge('{"app": {"name": "UpdatedApp"}, "newkey": "newval"}')
WriteLn(f"Merged name: {ConfigGet('app.name')}")
WriteLn(f"New key: {ConfigGet('newkey')}")

// === Test 4: Config set ===
WriteLn("=== Test 4: Config set ===")
ConfigSet("app.custom", "hello")
WriteLn(f"Custom: {ConfigGet('app.custom')}")

// === Test 5: Log levels ===
WriteLn("=== Test 5: Logging ===")
LogSetLevel("debug")
LogDebug("Testing debug message")
LogInfo("Testing info message")
LogWarn("Testing warning message")
LogError("Testing error message")
LogAudit("Testing audit message")

// === Test 6: Log with categories ===
WriteLn("=== Test 6: Log categories ===")
LogInfo("pipeline", "Processing order 42")
LogAudit("auth", "User admin accessed sensitive data")

// === Test 7: Log level filtering ===
WriteLn("=== Test 7: Level filtering ===")
LogSetLevel("warn")
LogDebug("This should not appear")
LogInfo("This should not appear either")
LogWarn("This warning should appear")
LogError("This error should appear")
LogAudit("Audit always appears regardless of level")

// === Test 8: Trace ID ===
WriteLn("=== Test 8: Trace ID ===")
local TraceId := LogNewTraceId()
WriteLn(f"Trace ID generated: {TraceId}")
LogSetLevel("info")
LogInfo("pipeline", "Step with trace context")

// === Test 9: Config for pipeline settings ===
WriteLn("=== Test 9: Pipeline config ===")
ConfigLoad('{"pipelines": {"logging": true, "timing": true, "log_level": "debug"}}')
WriteLn(f"Pipeline logging: {ConfigGetBool('pipelines.logging')}")
WriteLn(f"Pipeline timing: {ConfigGetBool('pipelines.timing')}")
WriteLn(f"Pipeline log level: {ConfigGet('pipelines.log_level')}")

WriteLn("=== All config_log tests passed ===")
