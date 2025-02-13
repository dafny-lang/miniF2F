include "../utils.dfy"

lemma mathd_numbertheory_780(m: nat, x: nat)
  requires 10 <= m <= 99
  requires (6 * x) % m == 1
  requires (x - 6*6) % m == 0
  ensures m == 43
{}