include "../utils.dfy"

import opened Utils

lemma numbertheory_2pownm1prime_nprime(n: nat)
  requires 0 < n
  requires prime(pow(2, n) - 1)
  ensures prime(n)
{}