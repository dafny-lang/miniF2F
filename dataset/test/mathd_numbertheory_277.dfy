// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_277(m: nat, n: nat)
  requires m > 0 // added
  requires n > 0 // added
  requires gcd(m, n) == 6
  requires lcm(m, n) == 126
  ensures 60 <= m + n
{}