include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_185(n: nat)
  requires n % 5 == 3
  ensures (2*n) % 5 == 1
{}