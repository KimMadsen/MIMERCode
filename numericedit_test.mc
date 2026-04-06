// numericedit_test.mc - BigNum types + NumericEdit control test
// Copyright 2026 Components4Developers - Kim Bo Madsen

program NumericeditTest

// === BigInt Tests ===
WriteLn("=== BigInt Tests ===")

local A := bigint("123456789012345678901234567890")
WriteLn(f"A = {str(A)}")
WriteLn(f"A digits = {bignum_digits(A)}")
WriteLn(f"A fits int64 = {bignum_fits_int64(A)}")
WriteLn(f"is_bigint(A) = {is_bigint(A)}")

local B := bigint("987654321098765432109876543210")
WriteLn(f"B = {str(B)}")

local C := A + B
WriteLn(f"A + B = {str(C)}")

local D := B - A
WriteLn(f"B - A = {str(D)}")

local E := bigint("12345") * bigint("67890")
WriteLn(f"12345 * 67890 = {str(E)}")

local F := bigint("1000000000000") / bigint("7")
WriteLn(f"1000000000000 / 7 = {str(F)}")

local G := bigint("1000000000000") mod bigint("7")
WriteLn(f"1000000000000 mod 7 = {str(G)}")

// Small values
local H := bigint(42)
WriteLn(f"bigint(42) = {str(H)}")

// Base conversion
local HexVal := bigint("FF", 16)
WriteLn(f"bigint('FF', 16) = {str(HexVal)}")

local BinVal := bigint("11010110", 2)
WriteLn(f"bigint('11010110', 2) = {str(BinVal)}")
WriteLn(f"  as hex = {bignum_base(BinVal, 16)}")
WriteLn(f"  as bin = {bignum_base(BinVal, 2)}")

// Negative
local Neg := bigint("-99999999999999999999")
WriteLn(f"Neg = {str(Neg)}")
WriteLn(f"Neg + Neg = {str(Neg + Neg)}")

// === BigFloat Tests ===
WriteLn("")
WriteLn("=== BigFloat Tests ===")

local P := bigfloat("3.14159265358979323846264338327950288")
WriteLn(f"Pi = {str(P)}")
WriteLn(f"is_bigfloat(P) = {is_bigfloat(P)}")

local Q := bigfloat("2.71828182845904523536028747135266249")
WriteLn(f"E  = {str(Q)}")

local Sum := P + Q
WriteLn(f"Pi + E = {str(Sum)}")

local Prod := bigfloat("1.5") * bigfloat("2.5")
WriteLn(f"1.5 * 2.5 = {str(Prod)}")

local FromFloat := bigfloat(3.14)
WriteLn(f"bigfloat(3.14) = {str(FromFloat)}")

// === NumericEdit GUI Test ===
WriteLn("")
WriteLn("=== NumericEdit GUI Test ===")

view NumericDemo
  state
    Amount: Double := 0.0,
    HexVal: String := "0",
    OctVal: String := "0",
    BinVal: String := "0",
    BigVal: String := "0",
    Errors: String := ""
  end

  render
    vbox padding: 16, gap: 12, flex: 1
      label text: "NumericEdit Control Demo", style: "heading"
      end

      // Currency input
      label text: "Currency (0.00 - 99,999.99):"
      end
      numericedit value: Amount,
        min_decimals: 2, max_decimals: 2,
        allow_negative: false,
        min_value: 0.0, max_value: 99999.99,
        prefix: "$", thousands_separator: true,
        show_spin_buttons: true, step: 0.01,
        output: "float",
        on_change: func(V) Amount := V end,
        on_error: func(E) Errors := E end
      end

      // Hex input
      label text: "Hex Byte (00 - FF):"
      end
      numericedit value: HexVal,
        base: 16, max_digits: 2,
        allow_negative: false,
        output: "string",
        prefix: "0x",
        on_change: func(V) HexVal := V end
      end

      // Octal input
      label text: "Octal (0 - 777):"
      end
      numericedit value: OctVal,
        base: 8, max_digits: 3,
        allow_negative: false,
        output: "string",
        prefix: "0o",
        on_change: func(V) OctVal := V end
      end

      // Binary input
      label text: "Binary Byte (8 bits):"
      end
      numericedit value: BinVal,
        base: 2, max_digits: 8,
        allow_negative: false,
        output: "string",
        prefix: "0b",
        on_change: func(V) BinVal := V end
      end

      // BigInt input
      label text: "Big Integer (up to 50 digits):"
      end
      numericedit value: BigVal,
        max_digits: 50,
        allow_negative: true,
        output: "bigint",
        thousands_separator: true,
        on_change: func(V) BigVal := str(V) end
      end

      separator
      end

      // Status display
      label text: f"Amount: ${Amount}"
      end
      label text: f"Hex: 0x{HexVal}  Oct: 0o{OctVal}  Bin: 0b{BinVal}"
      end
      label text: f"BigInt: {BigVal}"
      end
      label text: f"Errors: {Errors}", foreground: "danger"
      end
    end
  end
end

// Option 3: view name in URI path
local App := serve("gui://NumericDemo",
  title: "NumericEdit Test",
  width: 500,
  height: 700
)
// No Mount needed - auto-mounted from URI

// Alternative syntax (Option 1):
// local App := serve("gui://",
//   view: "NumericDemo",
//   title: "NumericEdit Test",
//   width: 500,
//   height: 700
// )

WriteLn("=== All numericedit_test tests passed ===")
end
