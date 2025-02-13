include "../utils.dfy"

lemma mathd_algebra_327(a: real)
  requires (1.0 / 5.0) * abs(9.0 + 2.0*a) < 1.0
  ensures -7.0 < a < -2.0
{}