include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_24(x: real)
  requires x / 50.0 == 4.0
  ensures x == 2000.0
{}