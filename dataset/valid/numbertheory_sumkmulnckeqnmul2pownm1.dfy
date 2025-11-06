// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma numbertheory_sumkmulnckeqnmul2pownm1(n: nat)
  requires 0 < n
  ensures Int.sum(set k | 1 <= k <= n :: k, k => k*choose(n,k)) == n * Int.pow(2, n-1)
{}