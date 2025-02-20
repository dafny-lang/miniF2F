include "../utils.dfy"

lemma mathd_numbertheory_530(n: nat, k: nat)
  requires 0 < n
  requires 0 < k
  requires 5 < n / k < 6
  ensures 22 <= lcm(n, k) / gcd(n, k)
{}