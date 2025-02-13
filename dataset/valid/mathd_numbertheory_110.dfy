include "../utils.dfy"

lemma mathd_numbertheory_110(a: nat, b: nat)
  requires 0 < a
  requires 0 < b
  requires b <= a
  requires (a+b) % 10 == 2
  requires (2*a + b) % 10 == 1
  ensures (a-b) % 10 == 6
{}