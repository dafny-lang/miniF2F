// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma induction_ineq_nsqlefactn(n: nat)
  requires 4 <= n
  ensures n*n <= factorial(n)
{}