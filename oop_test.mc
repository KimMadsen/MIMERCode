// MimerCode OOP Test Suite
// Copyright 2026 Components4Developers - Kim Bo Madsen
// Run with: MimerCodeRunner oop_test.mc

program OOPTest

  WriteLn('=== MimerCode OOP Tests ===')
  WriteLn('')

  // --- 1. Basic class with fields and constructor ---
  WriteLn('1. Basic class:')

  class TPoint(TObject)
    public
      field X: Double
      field Y: Double

      constructor Create(AX: Double, AY: Double)
        X := AX
        Y := AY
      end

      func ToString() -> String
        return f'({X}, {Y})'
      end
    end
  end

  var P := create TPoint(3.0, 4.0)
  WriteLn(f'  P = {P.ToString()}')
  WriteLn(f'  P.X = {P.X}, P.Y = {P.Y}')
  free P
  WriteLn('')

  // --- 2. Methods ---
  WriteLn('2. Methods:')

  class TCounter(TObject)
    public
      field FCount: Integer

      constructor Create()
        FCount := 0
      end

      func Increment()
        FCount := FCount + 1
      end

      func GetCount() -> Integer
        return FCount
      end
    end
  end

  var C := create TCounter()
  C.Increment()
  C.Increment()
  C.Increment()
  WriteLn(f'  Count = {C.GetCount()}')
  free C
  WriteLn('')

  // --- 3. Inheritance ---
  WriteLn('3. Inheritance:')

  class TAnimal(TObject)
    public
      field FName: String

      constructor Create(const AName: String)
        FName := AName
      end

      func GetName() -> String
        return FName
      end

      func Speak() -> String virtual
        return FName + ' says ...'
      end
    end
  end

  class TDog(TAnimal)
    public
      constructor Create(const AName: String)
        inherited Create(AName)
      end

      func Speak() -> String override
        return GetName() + ' says Woof!'
      end
    end
  end

  class TCat(TAnimal)
    public
      constructor Create(const AName: String)
        inherited Create(AName)
      end

      func Speak() -> String override
        return GetName() + ' says Meow!'
      end
    end
  end

  var Dog := create TDog('Rex')
  var Cat := create TCat('Whiskers')
  WriteLn(f'  {Dog.GetName()}: {Dog.Speak()}')
  WriteLn(f'  {Cat.GetName()}: {Cat.Speak()}')
  free Dog
  free Cat
  WriteLn('')

  // --- 4. Field modification ---
  WriteLn('4. Field modification:')

  class TBox(TObject)
    public
      field Width: Integer
      field Height: Integer

      constructor Create(AW: Integer, AH: Integer)
        Width := AW
        Height := AH
      end

      func Area() -> Integer
        return Width * Height
      end
    end
  end

  var Box := create TBox(5, 10)
  WriteLn(f'  Box area = {Box.Area()}')
  Box.Width := 20
  WriteLn(f'  After resize: area = {Box.Area()}')
  free Box
  WriteLn('')

  // --- 5. Records ---
  WriteLn('5. Records:')

  record TVector2D
    field X: Double
    field Y: Double

    func Length() -> Double
      return Sqrt(X * X + Y * Y)
    end

    func ToString() -> String
      return f'({X}, {Y})'
    end
  end

  var V := create TVector2D(3.0, 4.0)
  WriteLn(f'  V = {V.ToString()}')
  WriteLn(f'  V.Length = {V.Length()}')
  free V
  WriteLn('')

  // --- 6. Multiple inheritance levels ---
  WriteLn('6. Multi-level inheritance:')

  class TShape(TObject)
    public
      field FColor: String

      constructor Create(const AColor: String)
        FColor := AColor
      end

      func Describe() -> String virtual
        return 'Shape (' + FColor + ')'
      end
    end
  end

  class TCircle(TShape)
    public
      field FRadius: Double

      constructor Create(const AColor: String, ARadius: Double)
        inherited Create(AColor)
        FRadius := ARadius
      end

      func Describe() -> String override
        return f'Circle (r={FRadius}, {FColor})'
      end
    end
  end

  var Circle := create TCircle('red', 5.0)
  WriteLn(f'  {Circle.Describe()}')
  free Circle
  WriteLn('')

  WriteLn('=== All OOP Tests Complete ===')

end
