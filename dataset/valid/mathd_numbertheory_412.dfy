include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_412(x: nat, y: nat)
  requires x % 19 == 4
  requires y % 19 == 7
  ensures (power(x+1, 2) * power(y+5, 3)) % 19 == 13
{}
