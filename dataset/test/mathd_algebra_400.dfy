include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_400(x: real)
  requires 5.0 + 500.0 / 100.0 * 10.0 == 110.0 / 100.0 * x
  ensures x == 50.0
{}