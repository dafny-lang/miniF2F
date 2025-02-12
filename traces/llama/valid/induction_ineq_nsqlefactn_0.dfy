include "../utils.dfy"

import opened Utils

lemma induction_ineq_nsqlefactn(n: nat)
  requires 4 <= n
  ensures n*n <= factorial(n)
{}