// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_99(n: nat)
  requires (2*n) % 47 == 15
  ensures n % 47 == 31
{}