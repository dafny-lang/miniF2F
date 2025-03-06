// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_247(n: nat)
  requires (3*n) % 2 == 11
  ensures n % 11 == 8
{}