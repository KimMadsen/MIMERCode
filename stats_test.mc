// stats_test.mc - Test statistics, array ops, random, and bitwise
// Copyright 2026 Components4Developers - Kim Bo Madsen

program StatsTest
  // ---- Statistics ----
  WriteLn("--- Statistics ---")
  var Data := [4, 8, 15, 16, 23, 42]
  WriteLn(f"data = {Data}")
  WriteLn(f"median      = {median(Data)}")
  WriteLn(f"stdev       = {stdev(Data)}")
  WriteLn(f"variance    = {variance(Data)}")
  WriteLn(f"percentile 0   = {percentile(Data, 0)}")
  WriteLn(f"percentile 25  = {percentile(Data, 25)}")
  WriteLn(f"percentile 50  = {percentile(Data, 50)}")
  WriteLn(f"percentile 75  = {percentile(Data, 75)}")
  WriteLn(f"percentile 100 = {percentile(Data, 100)}")

  var X := [1, 2, 3, 4, 5]
  var Y := [2, 4, 6, 8, 10]
  WriteLn(f"corrcoef(X, 2*X) = {corrcoef(X, Y)}")
  var Z := [10, 8, 6, 4, 2]
  WriteLn(f"corrcoef(X, -X)  = {corrcoef(X, Z)}")
  WriteLn("")

  // ---- Array operations ----
  WriteLn("--- Array ops ---")
  WriteLn(f"arange(5)        = {arange(5)}")
  WriteLn(f"arange(2, 8)     = {arange(2, 8)}")
  WriteLn(f"arange(0, 1, 0.25) = {arange(0, 1, 0.25)}")
  WriteLn(f"arange(10, 0, -3)  = {arange(10, 0, -3)}")

  var Unsorted := [3, 1, 4, 1, 5, 9, 2, 6]
  WriteLn(f"argsort({Unsorted}) = {argsort(Unsorted)}")

  var Dupes := [1, 2, 3, 2, 1, 4, 3]
  WriteLn(f"unique({Dupes})  = {unique(Dupes)}")

  var Nums := [1, 2, 3, 4, 5]
  WriteLn(f"cumsum({Nums})   = {cumsum(Nums)}")
  WriteLn(f"cumprod({Nums})  = {cumprod(Nums)}")
  WriteLn(f"diff({Nums})     = {diff(Nums)}")

  var Bools := [true, false, true, true]
  WriteLn(f"any({Bools})  = {any(Bools)}")
  WriteLn(f"all({Bools})  = {all(Bools)}")
  WriteLn(f"all([true, true]) = {all([true, true])}")
  WriteLn(f"any([false, false]) = {any([false, false])}")

  var Items := ["a", "b", "a", "c", "a", "b"]
  WriteLn(f"count(Items, 'a') = {count(Items, 'a')}")
  WriteLn(f"count(Items, 'c') = {count(Items, 'c')}")
  WriteLn(f"count(Bools)      = {count(Bools)}")
  WriteLn("")

  // ---- Random ----
  WriteLn("--- Random ---")
  seed(42)
  WriteLn(f"randint(1, 6) = {randint(1, 6)}")
  WriteLn(f"randint(1, 6) = {randint(1, 6)}")
  WriteLn(f"uniform(0, 1) = {uniform(0, 1)}")
  WriteLn(f"normal()      = {normal()}")
  WriteLn(f"normal(100, 15) = {normal(100, 15)}")
  var Colors := ["red", "green", "blue", "yellow"]
  WriteLn(f"choice(Colors)  = {choice(Colors)}")
  WriteLn(f"shuffle([1,2,3,4,5]) = {shuffle([1, 2, 3, 4, 5])}")
  WriteLn("")

  // ---- Bitwise ----
  WriteLn("--- Bitwise ---")
  WriteLn(f"bitand(12, 10)  = {bitand(12, 10)}")
  WriteLn(f"bitor(12, 10)   = {bitor(12, 10)}")
  WriteLn(f"bitxor(12, 10)  = {bitxor(12, 10)}")
  WriteLn(f"bitnot(0)       = {bitnot(0)}")
  WriteLn(f"shl(1, 8)       = {shl(1, 8)}")
  WriteLn(f"shr(256, 4)     = {shr(256, 4)}")
  WriteLn("")

  // ---- Verify identities ----
  WriteLn("--- Identity checks ---")
  WriteLn(f"variance = stdev^2: {near(variance(Data), stdev(Data) * stdev(Data))}")
  WriteLn(f"median([1,2,3]) = 2: {near(median([1, 2, 3]), 2.0)}")
  WriteLn(f"cumsum matches: {cumsum([1, 2, 3]) = [1, 3, 6]}")
  WriteLn(f"diff undoes cumsum: {diff(cumsum([1, 2, 3, 4])) = [2, 3, 4]}")
  WriteLn(f"bitand(0xFF, 0x0F) = 15: {bitand(255, 15) = 15}")
  WriteLn(f"shl(1,4) = 16: {shl(1, 4) = 16}")
end
