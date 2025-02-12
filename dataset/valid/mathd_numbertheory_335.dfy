include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_335(n: nat)
  requires n % 7 == 5
  ensures 5*n % 7 == 4
{}