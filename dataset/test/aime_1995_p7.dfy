include "../utils.dfy"

lemma aime_1995_p7(k: nat, m: nat, n: nat, t: real)
  requires 0 < k
  requires 0 < m
  requires 0 < n
  requires gcd(m, n) == 1
  requires (1.0 + sin(t)) * (1.0 + cos(t)) == 5.0/4.0
  requires (1.0 - sin(t)) * (1.0 - cos(t)) == (m as real)/(n as real) - sqrt(k as real)
  ensures k + m + n == 27
{}