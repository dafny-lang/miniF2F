include "../definitions.dfy"
include "../library.dfy"

lemma induction_sum2kp1npqsqm1(n: nat)
  ensures Int.sum(range(n), k => 2*k+3) == (n+1)*(n+1) - 1
{}