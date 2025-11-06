// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_125(x: nat, y: nat)
  requires 0 < x
  requires 0 < y
  requires 5*x == y
  requires x - 3 + y - 3 == 30
  ensures x == 6
{}