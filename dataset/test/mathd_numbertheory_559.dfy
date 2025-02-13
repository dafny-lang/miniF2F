include "../utils.dfy"

lemma mathd_numbertheory_559(x: nat, y: nat)
  requires x % 3 == 2
  requires y % 5 == 4
  requires x % 10 == y % 10
  ensures 14 <= x
{}