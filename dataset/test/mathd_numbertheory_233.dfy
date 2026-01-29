include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_233(b: nat)
  requires 0 <= b < 11*11
  requires (b * 24) % (11*11) == 1
  ensures b == 116
{}