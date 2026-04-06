// db_test.mc - Database channel test
// Copyright 2026 Components4Developers - Kim Bo Madsen

WriteLn("MimerCode DB Channel Test")
WriteLn("Version: " + MimerCodeVersion())
WriteLn("Has DB: " + Str(MimerCodeHasFeature("db")))
WriteLn("")

// Open SQLite database (created if not exists)
local db := open("db://sqlite/test_data.db")
WriteLn("Connected to SQLite")

// Create table if needed
if not db.TableExists("users") then
  WriteLn("Creating users table...")
  db.CreateTable("users", [
    dict{ "name": "id",      "type": "integer", "primary": true, "auto": true },
    dict{ "name": "name",    "type": "string",  "size": 100, "nullable": false },
    dict{ "name": "email",   "type": "string",  "size": 200, "unique": true },
    dict{ "name": "age",     "type": "integer",  "nullable": true },
    dict{ "name": "active",  "type": "boolean",  "default": "1" }
  ])
  WriteLn("Table created.")
end

// List tables
local tables := db.Tables()
WriteLn("Tables: " + Join(", ", tables))

// Insert some data
WriteLn("")
WriteLn("Inserting test data...")
local id1 := db.Insert("users", dict{
  "name": "Kim",
  "email": "kim@example.com",
  "age": 42,
  "active": true
})
WriteLn(f"Inserted Kim with id {id1}")

local id2 := db.Insert("users", dict{
  "name": "Alice",
  "email": "alice@example.com",
  "age": 30,
  "active": true
})
WriteLn(f"Inserted Alice with id {id2}")

local id3 := db.Insert("users", dict{
  "name": "Bob",
  "email": "bob@example.com",
  "age": 25,
  "active": false
})
WriteLn(f"Inserted Bob with id {id3}")

// Query all
WriteLn("")
WriteLn("All users:")
local users := db.Query("SELECT * FROM users ORDER BY name")
for user in users do
  WriteLn(f"  [{user['id']}] {user['name']} ({user['email']}) age={user['age']} active={user['active']}")
end

// Parameterized query
WriteLn("")
WriteLn("Active users over 25:")
local active := db.Query(
  "SELECT name, age FROM users WHERE active = :active AND age > :min_age",
  dict{ "active": 1, "min_age": 25 }
)
for user in active do
  WriteLn(f"  {user['name']} age={user['age']}")
end

// QueryOne
WriteLn("")
local kim := db.QueryOne(
  "SELECT * FROM users WHERE name = :name",
  dict{ "name": "Kim" }
)
if kim <> nil then
  WriteLn("Found Kim: " + kim["email"])
end

// QueryValue
local count := db.QueryValue("SELECT COUNT(*) FROM users")
WriteLn(f"Total users: {count}")

// Update
WriteLn("")
local affected := db.Update(
  "users",
  dict{ "age": 43 },
  "name = :name",
  dict{ "name": "Kim" }
)
WriteLn(f"Updated {affected} row(s)")

// Verify update
local updated := db.QueryValue(
  "SELECT age FROM users WHERE name = :name",
  dict{ "name": "Kim" }
)
WriteLn(f"Kim's new age: {updated}")

// Transaction test
WriteLn("")
WriteLn("Transaction test...")
db.BeginTransaction()
db.Exec(
  "UPDATE users SET active = :val WHERE name = :name",
  dict{ "val": false, "name": "Alice" }
)
db.Rollback()
local aliceActive := db.QueryValue(
  "SELECT active FROM users WHERE name = :name",
  dict{ "name": "Alice" }
)
WriteLn(f"Alice active after rollback: {aliceActive}")

// Delete
WriteLn("")
local deleted := db.Delete(
  "users",
  "name = :name",
  dict{ "name": "Bob" }
)
WriteLn(f"Deleted {deleted} row(s)")

// Column info
WriteLn("")
WriteLn("Columns in users:")
local cols := db.Columns("users")
for col in cols do
  WriteLn(f"  {col['name']}")
end

// Cleanup
db.RawExec("DROP TABLE IF EXISTS users")
WriteLn("")
WriteLn("Test complete. Table dropped.")
db.Close()
