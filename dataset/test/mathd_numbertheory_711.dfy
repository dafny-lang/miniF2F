// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_711(m: nat, n: nat)
  requires 0 < m
  requires 0 < n 
  requires gcd(m, n) == 8
  requires lcm(m, n) == 112
  ensures 72 <= m + n
{}