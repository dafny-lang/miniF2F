include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_185(n: nat)
  requires n % 5 == 3
  requires (2*n) % 5 == 1
{}