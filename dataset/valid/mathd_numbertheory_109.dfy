// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_109(v: nat -> nat)
  requires forall n :: v(n) == 2*n - 1
  ensures Int.sum(set k | 1 <= k <= 100 :: k, k => v(k)) % 7 == 4
{}