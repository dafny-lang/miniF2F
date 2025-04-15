// Author: Stefan Zetzsche

include "../utils.dfy"

lemma induction_sum_odd(n: nat)
  ensures Int.sum(range(n), k => 2*k + 1) == n*n
{}