include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_34(x: nat)
  requires x < 100
  requires x*9 % 100 == 1
  ensures x == 89
{}