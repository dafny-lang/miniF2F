include "../utils.dfy"

lemma mathd_algebra_109(a: real, b: real)
  requires 3.0*a + 2.0*b == 12.0
  requires a == 4.0
  ensures b == 0.0
{}