// data_test.mc - Test JSON and CSV functions
// Copyright 2026 Components4Developers - Kim Bo Madsen

program DataTest
  // ================================================================
  // JSON
  // ================================================================
  WriteLn("--- JSON Parse ---")

  // Parse object
  var Obj := json_parse('{"name": "Alice", "age": 30, "active": true}')
  WriteLn(f"name={Obj['name']}, age={Obj['age']}, active={Obj['active']}")

  // Parse array
  var Arr := json_parse('[1, 2, 3, "hello", null, false]')
  WriteLn(f"array length={Length(Arr)}, [3]={Arr[3]}, [4]={Arr[4]}, [5]={Arr[5]}")

  // Parse nested
  var Nested := json_parse('{"users": [{"id": 1, "name": "Bob"}, {"id": 2, "name": "Carol"}]}')
  WriteLn(f"users[0].name = {Nested['users'][0]['name']}")
  WriteLn(f"users[1].id = {Nested['users'][1]['id']}")

  // Parse numbers
  var Nums := json_parse('{"int": 42, "float": 3.14, "neg": -7, "big": 1234567890}')
  WriteLn(f"int={Nums['int']}, float={Nums['float']}, neg={Nums['neg']}, big={Nums['big']}")
  WriteLn("")

  WriteLn("--- JSON Stringify ---")

  // Stringify dict
  var D := dict{"city": "Copenhagen", "pop": 1400000, "eu": true}
  var Json := json_stringify(D)
  WriteLn(f"compact: {Json}")

  // Pretty print
  var Pretty := json_stringify(D, 2)
  WriteLn(f"pretty:\n{Pretty}")

  // Stringify array
  WriteLn(f"array: {json_stringify([1, 2, 3])}")

  // Stringify with special chars
  var Special := dict{"msg": "He said \"hello\"", "path": "C:\\Users"}
  WriteLn(f"escaped: {json_stringify(Special)}")

  // Round trip
  var Original := dict{"a": 1, "b": [2, 3], "c": dict{"d": true}}
  var RoundTrip := json_parse(json_stringify(Original))
  WriteLn(f"round-trip a={RoundTrip['a']}, b[1]={RoundTrip['b'][1]}, c.d={RoundTrip['c']['d']}")
  WriteLn("")

  // ================================================================
  // CSV
  // ================================================================
  WriteLn("--- CSV Parse ---")

  // Basic CSV
  var CsvText := "Name,Age,City\nAlice,30,Copenhagen\nBob,25,London\nCarol,35,\"New York\""
  var Rows := csv_parse(CsvText)
  WriteLn(f"raw rows: {Length(Rows)}")
  WriteLn(f"row 0: {Rows[0]}")
  WriteLn(f"row 1: {Rows[1]}")

  // With headers -> array of dicts
  var DictRows := csv_parse(CsvText, dict{"headers": true})
  WriteLn(f"dict rows: {Length(DictRows)}")
  WriteLn(f"row 0 name={DictRows[0]['Name']}, city={DictRows[0]['City']}")
  WriteLn(f"row 2 name={DictRows[2]['Name']}, city={DictRows[2]['City']}")

  // Tab-separated
  var TsvText := "Name\tScore\nAlice\t95\nBob\t87"
  var TsvRows := csv_parse(TsvText, dict{"headers": true, "delimiter": "\t"})
  WriteLn(f"TSV: {TsvRows[0]['Name']} scored {TsvRows[0]['Score']}")

  // Quoted fields with commas and newlines
  var QuotedCsv := "field1,\"field,with,commas\",field3\na,\"line1\nline2\",c"
  var QRows := csv_parse(QuotedCsv)
  WriteLn(f"quoted field: {QRows[0][1]}")
  WriteLn("")

  WriteLn("--- CSV Stringify ---")

  // From array of dicts
  var People := [
    dict{"Name": "Alice", "Age": "30", "City": "Copenhagen"},
    dict{"Name": "Bob", "Age": "25", "City": "London"},
    dict{"Name": "Carol", "Age": "35", "City": "New York"}
  ]
  var CsvOut := csv_stringify(People)
  WriteLn(f"dict CSV:\n{CsvOut}")

  // From array of arrays
  var Grid := [["A", "B", "C"], ["1", "2", "3"], ["x", "y", "z"]]
  WriteLn(f"array CSV:\n{csv_stringify(Grid)}")

  // TSV output
  var TsvOut := csv_stringify(People, dict{"delimiter": "\t", "headers": true})
  WriteLn(f"TSV:\n{TsvOut}")

  // Round trip
  var Csv2 := csv_stringify(People)
  var Parsed := csv_parse(Csv2, dict{"headers": true})
  WriteLn(f"CSV round-trip: {Parsed[0]['Name']}, {Parsed[1]['City']}, {Parsed[2]['Age']}")

  WriteLn("")
  WriteLn("--- Identity checks ---")
  WriteLn(f"json round-trip: {json_parse(json_stringify(42)) = 42}")
  WriteLn(f"json null: {json_parse('null') = nil}")
  WriteLn(f"csv row count: {Length(csv_parse('a,b\n1,2\n3,4', dict{'headers': true})) = 2}")
end
