include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_80(x: real)
  requires x != -1.0
  requires (x - 9.0) / (x + 1.0) == 2.0
  ensures x == -11.0
{}