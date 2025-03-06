// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_156(n: nat)
  requires 0 < n
  ensures gcd(n+7, 2*n+1) <= 13
{}