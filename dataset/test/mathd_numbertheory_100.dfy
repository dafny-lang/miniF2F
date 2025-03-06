// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_100(n: nat)
  requires 0 < n
  requires gcd(n, 40) == 10
  requires lcm(n, 40) == 280
  ensures n == 70
{}