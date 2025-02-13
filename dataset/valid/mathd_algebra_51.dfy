include "../utils.dfy"

lemma mathd_algebra_51(a: real, b: real)
  requires 0.0 < a
  requires 0.0 < b
  requires a + b == 35.0
  requires a == (2.0 / 5.0) * b
  ensures b - a == 15.0
{}