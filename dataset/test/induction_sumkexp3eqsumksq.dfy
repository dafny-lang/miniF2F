// Author: Stefan Zetzsche

include "../utils.dfy"

lemma induction_sumkexp3eqsumksq(n: nat)
  ensures Int.sum(range(n), k => k*k*k) == Int.pow(Int.sum(range(n), k => k), 2)
{}