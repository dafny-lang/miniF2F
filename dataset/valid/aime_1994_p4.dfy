// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma aime_1994_p4(n: nat)
  requires 0 < n
  requires Int.sum(set k | 1 <= k <= n :: k, k => floor(logb(2.0, k as real))) == 1994
  ensures n == 312
{}