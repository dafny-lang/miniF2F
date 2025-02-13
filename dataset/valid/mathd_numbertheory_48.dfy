include "../utils.dfy"

lemma mathd_numbertheory_48(b: nat)
  requires 0 < b
  requires 3*b*b + 2*b + 1 == 57
  ensures b == 4
{}