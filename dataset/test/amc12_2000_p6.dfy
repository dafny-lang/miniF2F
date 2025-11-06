// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12_2000_p6(p: nat, q: nat)
  requires prime(p)
  requires prime(q)
  requires 4 <= p <= 18
  requires 4 <= q <= 18
  ensures p*q - (p+q) != 194
{}