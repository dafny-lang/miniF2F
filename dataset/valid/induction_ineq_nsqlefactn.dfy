include "../utils.dfy"

lemma induction_ineq_nsqlefactn(n: nat)
  requires 4 <= n
  ensures n*n <= factorial(n)
{}