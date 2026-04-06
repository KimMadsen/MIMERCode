// MimerCode OOP Advanced Test Suite
// Tests: class methods, is operator, interface registration, properties
// Copyright 2026 Components4Developers - Kim Bo Madsen
// Run with: MimerCodeRunner oop_intf_test.mc

program OOPIntfTest

  WriteLn("=== MimerCode OOP Advanced Tests ===")
  WriteLn("")

  // -------------------------------------------------------
  // 1. Interface declaration and implementation
  // -------------------------------------------------------
  WriteLn("1. Interface declaration and class implementation:")

  interface IDrawable(IInterface)
    func Draw() -> String
    func GetBounds() -> String
  end

  interface IResizable(IInterface)
    func Resize(AScale: Double)
  end

  class TShape(TObject)
    public
      field FColor: String

      constructor Create(const AColor: String)
        FColor := AColor
      end

      func Describe() -> String virtual
        return "Shape (" + FColor + ")"
      end
    end
  end

  class TCircle(TShape, IDrawable)
    private
      field FRadius: Double
    public
      constructor Create(const AColor: String, ARadius: Double)
        inherited Create(AColor)
        FRadius := ARadius
      end

      func Draw() -> String
        return "Drawing circle r=" + FloatToStr(FRadius)
      end

      func GetBounds() -> String
        return "Bounds: circle r=" + FloatToStr(FRadius)
      end

      func Describe() -> String override
        return "Circle (r=" + FloatToStr(FRadius) + ", " + FColor + ")"
      end
    end
  end

  class TRect(TShape, IDrawable, IResizable)
    private
      field FWidth: Double
      field FHeight: Double
    public
      constructor Create(const AColor: String, AW: Double, AH: Double)
        inherited Create(AColor)
        FWidth := AW
        FHeight := AH
      end

      func Draw() -> String
        return "Drawing rect " + FloatToStr(FWidth) + "x" + FloatToStr(FHeight)
      end

      func GetBounds() -> String
        return "Bounds: rect " + FloatToStr(FWidth) + "x" + FloatToStr(FHeight)
      end

      func Resize(AScale: Double)
        FWidth := FWidth * AScale
        FHeight := FHeight * AScale
      end

      func Describe() -> String override
        return "Rect (" + FloatToStr(FWidth) + "x" + FloatToStr(FHeight) + ", " + FColor + ")"
      end
    end
  end

  var C := create TCircle("red", 5.0)
  var R := create TRect("blue", 10.0, 20.0)
  WriteLn("  Circle: " + C.Draw())
  WriteLn("  Rect:   " + R.Draw())
  WriteLn("  Circle bounds: " + C.GetBounds())
  WriteLn("  Rect describe: " + R.Describe())
  WriteLn("")

  // -------------------------------------------------------
  // 2. The 'is' operator - class hierarchy checks
  // -------------------------------------------------------
  WriteLn("2. 'is' operator - class hierarchy:")

  if C is TCircle then
    WriteLn("  C is TCircle: True")
  else
    WriteLn("  C is TCircle: False")
  end

  if C is TShape then
    WriteLn("  C is TShape: True (inheritance)")
  else
    WriteLn("  C is TShape: False")
  end

  if R is TCircle then
    WriteLn("  R is TCircle: True")
  else
    WriteLn("  R is TCircle: False (correct)")
  end

  if R is TShape then
    WriteLn("  R is TShape: True (inheritance)")
  else
    WriteLn("  R is TShape: False")
  end
  WriteLn("")

  // -------------------------------------------------------
  // 3. The 'is' operator - interface checks
  // -------------------------------------------------------
  WriteLn("3. 'is' operator - interface checks:")

  if C is IDrawable then
    WriteLn("  C is IDrawable: True")
  else
    WriteLn("  C is IDrawable: False")
  end

  if C is IResizable then
    WriteLn("  C is IResizable: True")
  else
    WriteLn("  C is IResizable: False (correct - TCircle does not implement)")
  end

  if R is IDrawable then
    WriteLn("  R is IDrawable: True")
  else
    WriteLn("  R is IDrawable: False")
  end

  if R is IResizable then
    WriteLn("  R is IResizable: True")
  else
    WriteLn("  R is IResizable: False")
  end
  WriteLn("")

  // -------------------------------------------------------
  // 4. Properties - read via field, read via getter, write
  // -------------------------------------------------------
  WriteLn("4. Properties:")

  class TEmployee(TObject)
    private
      field FName: String
      field FAge: Integer
      field FSalary: Double
    public
      constructor Create(const AName: String, AAge: Integer, ASalary: Double)
        FName := AName
        FAge := AAge
        FSalary := ASalary
      end

      func GetName() -> String
        return FName
      end

      func SetName(const AValue: String)
        FName := AValue
      end

      func GetSalary() -> Double
        return FSalary
      end

      // Property read via getter method, write via setter method
      prop Name: String read GetName write SetName
      // Property read via field directly, write via field directly
      prop Age: Integer read FAge write FAge
      // Property read-only via getter
      prop Salary: Double read GetSalary
    end
  end

  var Emp := create TEmployee("Alice", 30, 75000.0)
  WriteLn("  Name (prop read via getter): " + Emp.Name)
  WriteLn("  Age (prop read via field):   " + IntToStr(Emp.Age))
  WriteLn("  Salary (prop read-only):     " + FloatToStr(Emp.Salary))

  // Write via property setter
  Emp.Name := "Bob"
  WriteLn("  After Name := Bob: " + Emp.Name)

  // Write via property field
  Emp.Age := 42
  WriteLn("  After Age := 42:   " + IntToStr(Emp.Age))
  WriteLn("")

  // -------------------------------------------------------
  // 5. Class methods (static methods on the class itself)
  // -------------------------------------------------------
  WriteLn("5. Class methods:")

  class TCounter(TObject)
    private
      class field FInstanceCount: Integer
    public
      field FId: Integer

      class func GetInstanceCount() -> Integer
        return FInstanceCount
      end

      class func IncrementCount()
        FInstanceCount := FInstanceCount + 1
      end

      constructor Create()
        TCounter.IncrementCount()
        FId := TCounter.GetInstanceCount()
      end
    end
  end

  // Class field starts at nil (0 for integer context)
  WriteLn("  Initial count: " + IntToStr(TCounter.GetInstanceCount()))

  var C1 := create TCounter()
  WriteLn("  After C1: count = " + IntToStr(TCounter.GetInstanceCount()))
  WriteLn("  C1.FId = " + IntToStr(C1.FId))

  var C2 := create TCounter()
  WriteLn("  After C2: count = " + IntToStr(TCounter.GetInstanceCount()))
  WriteLn("  C2.FId = " + IntToStr(C2.FId))

  var C3 := create TCounter()
  WriteLn("  After C3: count = " + IntToStr(TCounter.GetInstanceCount()))
  WriteLn("  C3.FId = " + IntToStr(C3.FId))

  free C1
  free C2
  free C3
  WriteLn("")

  // -------------------------------------------------------
  // 6. Class field access via instance
  // -------------------------------------------------------
  WriteLn("6. Class field access via instance dot notation:")

  class TConfig(TObject)
    public
      class field FVersion: String
      field FLabel: String

      constructor Create(const ALabel: String)
        FLabel := ALabel
      end

      class func SetVersion(const AVal: String)
        FVersion := AVal
      end

      func GetInfo() -> String
        return FLabel + " v" + FVersion
      end
    end
  end

  TConfig.SetVersion("2.0")
  var Cfg1 := create TConfig("Alpha")
  var Cfg2 := create TConfig("Beta")
  WriteLn("  Cfg1.GetInfo() = " + Cfg1.GetInfo())
  WriteLn("  Cfg2.GetInfo() = " + Cfg2.GetInfo())

  // Both instances see the same class field
  TConfig.SetVersion("3.0")
  WriteLn("  After version bump:")
  WriteLn("  Cfg1.GetInfo() = " + Cfg1.GetInfo())
  WriteLn("  Cfg2.GetInfo() = " + Cfg2.GetInfo())
  free Cfg1
  free Cfg2
  WriteLn("")

  // -------------------------------------------------------
  // 7. Polymorphic dispatch through interface-typed loop
  // -------------------------------------------------------
  WriteLn("7. Polymorphic dispatch:")

  var Shapes: TArray<TObject>
  Shapes := [create TCircle("green", 3.0), create TRect("yellow", 8.0, 4.0), create TCircle("purple", 1.5)]

  for S in Shapes do
    if S is IDrawable then
      // Call Draw method polymorphically
      WriteLn("  " + S.Draw())
    end
    if S is IResizable then
      WriteLn("    (also resizable)")
    end
  end

  // Cleanup
  for S in Shapes do
    free S
  end
  WriteLn("")

  // -------------------------------------------------------
  // Cleanup
  // -------------------------------------------------------
  free C
  free R
  free Emp

  WriteLn("=== All OOP Advanced Tests Complete ===")

end
