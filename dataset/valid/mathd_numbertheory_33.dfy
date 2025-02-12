include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_33(n: nat)
  requires n < 398
  requires (n*7) % 398 == 1
  ensures n == 57
{}