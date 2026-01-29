include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_158(a: nat)
  requires a % 2 == 0
  requires Int.sum(range(8), k => 2*k+1) - Int.sum(range(5), k => a+2*k) == 4
  ensures a == 8
{}