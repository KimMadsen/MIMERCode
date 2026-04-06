// math_test.mc - Test new math functions and constants
// Copyright 2026 Components4Developers - Kim Bo Madsen

program MathTest
  // ---- Constants ----
  WriteLn(f"pi  = {pi}")
  WriteLn(f"e   = {e}")
  WriteLn(f"tau = {tau}")
  WriteLn(f"inf = {inf}")
  WriteLn(f"nan = {nan}")
  WriteLn("")

  // ---- Trigonometric ----
  WriteLn("--- Trig ---")
  WriteLn(f"sin(pi/2)     = {sin(pi / 2)}")
  WriteLn(f"cos(0)        = {cos(0)}")
  WriteLn(f"tan(pi/4)     = {tan(pi / 4)}")
  WriteLn(f"asin(1)       = {asin(1)}")
  WriteLn(f"acos(1)       = {acos(1)}")
  WriteLn(f"atan(1)       = {atan(1)}")
  WriteLn(f"atan2(1, 1)   = {atan2(1, 1)}")
  WriteLn(f"degrees(pi)   = {degrees(pi)}")
  WriteLn(f"radians(180)  = {radians(180)}")
  WriteLn("")

  // ---- Hyperbolic ----
  WriteLn("--- Hyperbolic ---")
  WriteLn(f"sinh(1)  = {sinh(1)}")
  WriteLn(f"cosh(1)  = {cosh(1)}")
  WriteLn(f"tanh(1)  = {tanh(1)}")
  WriteLn(f"asinh(1) = {asinh(1)}")
  WriteLn(f"acosh(2) = {acosh(2)}")
  WriteLn(f"atanh(0.5) = {atanh(0.5)}")
  WriteLn("")

  // ---- Exponential / Logarithmic ----
  WriteLn("--- Exp/Log ---")
  WriteLn(f"exp(1)        = {exp(1)}")
  WriteLn(f"exp2(10)      = {exp2(10)}")
  WriteLn(f"log(e)        = {log(e)}")
  WriteLn(f"log(100, 10)  = {log(100, 10)}")
  WriteLn(f"log2(1024)    = {log2(1024)}")
  WriteLn(f"log10(1000)   = {log10(1000)}")
  WriteLn("")

  // ---- Sign / Classification ----
  WriteLn("--- Sign/Classify ---")
  WriteLn(f"sign(-5)      = {sign(-5)}")
  WriteLn(f"sign(0)       = {sign(0)}")
  WriteLn(f"sign(3.14)    = {sign(3.14)}")
  WriteLn(f"clamp(15, 0, 10) = {clamp(15, 0, 10)}")
  WriteLn(f"clamp(-3, 0, 10) = {clamp(-3, 0, 10)}")
  WriteLn(f"clamp(5, 0, 10)  = {clamp(5, 0, 10)}")
  WriteLn(f"hypot(3, 4)   = {hypot(3, 4)}")
  WriteLn(f"fmod(7.5, 3)  = {fmod(7.5, 3)}")
  WriteLn(f"copysign(3, -1) = {copysign(3, -1)}")
  WriteLn(f"isnan(nan)    = {isnan(nan)}")
  WriteLn(f"isnan(1.0)    = {isnan(1.0)}")
  WriteLn(f"isinf(inf)    = {isinf(inf)}")
  WriteLn(f"isinf(1.0)    = {isinf(1.0)}")
  WriteLn(f"isfinite(1.0) = {isfinite(1.0)}")
  WriteLn(f"isfinite(inf) = {isfinite(inf)}")
  WriteLn(f"isfinite(nan) = {isfinite(nan)}")
  WriteLn("")

  // ---- Combinatorial ----
  WriteLn("--- Combinatorial ---")
  WriteLn(f"factorial(0)  = {factorial(0)}")
  WriteLn(f"factorial(5)  = {factorial(5)}")
  WriteLn(f"factorial(10) = {factorial(10)}")
  WriteLn(f"factorial(20) = {factorial(20)}")
  WriteLn(f"gcd(48, 18)   = {gcd(48, 18)}")
  WriteLn(f"gcd(0, 5)     = {gcd(0, 5)}")
  WriteLn(f"lcm(4, 6)     = {lcm(4, 6)}")
  WriteLn(f"lcm(0, 5)     = {lcm(0, 5)}")
  WriteLn("")

  // ---- Verify key identities ----
  WriteLn("--- Identity checks ---")
  WriteLn(f"sin^2 + cos^2 = {near(sin(1)*sin(1) + cos(1)*cos(1), 1.0)}")
  WriteLn(f"exp(log(5))   = {near(exp(log(5)), 5.0)}")
  WriteLn(f"tau = 2*pi    = {near(tau, 2 * pi)}")
  WriteLn(f"e = exp(1)    = {near(e, exp(1))}")
  WriteLn(f"asinh(sinh(2))= {near(asinh(sinh(2)), 2.0)}")
  WriteLn(f"acosh(cosh(2))= {near(acosh(cosh(2)), 2.0)}")
  WriteLn(f"atanh(tanh(0.5))= {near(atanh(tanh(0.5)), 0.5)}")
end
