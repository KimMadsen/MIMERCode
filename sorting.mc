// MimerCode Sample - Sorting Algorithms
// Copyright 2026 Components4Developers - Kim Bo Madsen
// Run with: MimerCodeRunner sorting.mc

program Sorting

  // --- Bubble Sort ---
  func BubbleSort(var Arr: TArray<Integer>)
    local N: Integer
    N := Length(Arr)
    local Swapped: Boolean
    local Temp: Integer
    for I := 0 to N - 2 do
      Swapped := False
      for J := 0 to N - 2 - I do
        if Arr[J] > Arr[J + 1] then
          Temp := Arr[J]
          Arr[J] := Arr[J + 1]
          Arr[J + 1] := Temp
          Swapped := True
        end
      end
      if not Swapped then
        break
      end
    end
  end

  // --- Selection Sort ---
  func SelectionSort(var Arr: TArray<Integer>)
    local N: Integer
    N := Length(Arr)
    local MinIdx: Integer
    local Temp: Integer
    for I := 0 to N - 2 do
      MinIdx := I
      for J := I + 1 to N - 1 do
        if Arr[J] < Arr[MinIdx] then
          MinIdx := J
        end
      end
      if MinIdx <> I then
        Temp := Arr[I]
        Arr[I] := Arr[MinIdx]
        Arr[MinIdx] := Temp
      end
    end
  end

  // --- Insertion Sort ---
  func InsertionSort(var Arr: TArray<Integer>)
    local N: Integer
    N := Length(Arr)
    local Key: Integer
    local J: Integer
    for I := 1 to N - 1 do
      Key := Arr[I]
      J := I - 1
      while (J >= 0) and (Arr[J] > Key) do
        Arr[J + 1] := Arr[J]
        J -= 1
      end
      Arr[J + 1] := Key
    end
  end

  // --- Helper: print array ---
  func PrintArray(const Label: String, const Arr: TArray<Integer>)
    local S: String = ''
    for I := 0 to Length(Arr) - 1 do
      if I > 0 then
        S += ', '
      end
      S += IntToStr(Arr[I])
    end
    WriteLn(f'{Label}: [{S}]')
  end

  // --- Run demos ---
  local Data1: TArray<Integer>
  Data1 := [64, 34, 25, 12, 22, 11, 90]
  PrintArray('Before bubble sort', Data1)
  BubbleSort(Data1)
  PrintArray('After bubble sort ', Data1)
  WriteLn('')

  local Data2: TArray<Integer>
  Data2 := [29, 10, 14, 37, 13, 8, 55]
  PrintArray('Before selection sort', Data2)
  SelectionSort(Data2)
  PrintArray('After selection sort ', Data2)
  WriteLn('')

  local Data3: TArray<Integer>
  Data3 := [5, 2, 4, 6, 1, 3, 9, 7, 8]
  PrintArray('Before insertion sort', Data3)
  InsertionSort(Data3)
  PrintArray('After insertion sort ', Data3)

end
