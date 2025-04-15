// Author: Stefan Zetzsche

include "../utils.dfy"

lemma imo_1967_p3(k: nat, m: nat, n: nat, c: nat -> nat)
  requires 0 < k
  requires 0 < m
  requires 0 < n 
  requires forall s :: c(s) == s*(s+1)
  requires prime(k+m+1)
  requires n + 1 < k + m + 1
  ensures Int.prod(set k | 1 <= k <= n :: k, k => c(m+k) - c(k)) % Int.prod(set k | 1 <= k <= n :: k, k => c(k)) == 0
{}