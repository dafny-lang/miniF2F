include "../definitions.dfy"
include "../library.dfy"

// added x != y
lemma mathd_algebra_139(s: real -> real -> real)
  requires forall x,y | x != 0.0 && y != 0.0 && x != y :: s(x)(y) == (1.0/y - 1.0/x) / (x-y)
  ensures s(3.0)(11.0) == 1.0 / 33.0
{}