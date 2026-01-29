include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_92(n: nat)
  requires (5 * n) % 17 == 8
  ensures n % 17 == 5
{}