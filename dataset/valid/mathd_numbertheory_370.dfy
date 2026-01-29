include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_370(n: nat)
  requires n % 7 == 3
  ensures (2*n + 1) % 7 == 0
{}