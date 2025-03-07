// Author: Stefan Zetzsche

include "../utils.dfy"

lemma numbertheory_nckeqnm1ckpnm1ckm1(n: nat, k: nat)
  requires 0 < n
  requires 0 < k
  requires k <= n
  ensures choose(n, k) == choose(n-1, k) + choose(n-1, k-1)
{}