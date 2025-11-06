// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_251(x: real)
  requires x != 0.0
  requires 3.0 + 1.0 / x == 7.0 / x
  ensures x == 2.0
{}