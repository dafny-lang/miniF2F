include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_301(j: nat)
  requires 0 < j
  ensures (3 * (7*j + 3)) % 7 == 2
{}