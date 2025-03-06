// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_412(x: nat, y: nat)
  requires x % 19 == 4
  requires y % 19 == 7
  ensures (Int.pow(x+1, 2) * Int.pow(y+5, 3)) % 19 == 13
{}