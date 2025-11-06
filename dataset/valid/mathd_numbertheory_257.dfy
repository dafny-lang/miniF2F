// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_257(x: nat)
  requires 1 <= x <= 100
  requires Int.sum(range(101), k => k-x) % 77 == 0
  ensures x == 45
{}