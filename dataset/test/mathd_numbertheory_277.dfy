include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_277(m: nat, n: nat)
  requires 0 < m // added
  requires 0 < n // added
  requires gcd(m, n) == 6
  requires lcm(m, n) == 126
  ensures 60 <= m + n
{}