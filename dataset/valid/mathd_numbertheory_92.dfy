include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_92(n: nat)
  requires (5 * n) % 17 == 8
  ensures n % 17 == 5
{}