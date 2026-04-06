// Minimal OOP test
program OOPMin

  WriteLn('Step 1: before class')

  class TPoint(TObject)
    public
      field X: Double
      field Y: Double

      constructor Create(AX: Double, AY: Double)
        X := AX
        Y := AY
      end
    end
  end

  WriteLn('Step 2: after class')

  var P := create TPoint(3.0, 4.0)

  WriteLn('Step 3: after create')

  WriteLn(f'  P.X = {P.X}')

  WriteLn('Step 4: after field access')

  free P

  WriteLn('Step 5: done')

end
