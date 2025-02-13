include "../utils.dfy"

lemma mathd_numbertheory_521(m: nat, n: nat)
  requires m % 2 == 0
  requires n % 2 == 0
  requires m - n == 2
  requires m * n == 288
  ensures m == 18
{}