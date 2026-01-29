include "../definitions.dfy"
include "../library.dfy"

lemma aime_1990_p15(a: real, b: real, x: real, y: real)
  requires a * x + b * y == 3.0
  requires a * Real.pow(x, 2) + b * Real.pow(y, 2) == 7.0
  requires a * Real.pow(x, 3) + b * Real.pow(y, 3) == 16.0
  requires a * Real.pow(x, 4) + b * Real.pow(y, 4) == 42.0
  ensures a * Real.pow(x, 5) + b * Real.pow(y, 5) == 20.0
{}