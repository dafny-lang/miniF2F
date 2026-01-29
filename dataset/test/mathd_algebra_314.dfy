include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_314(n: nat)
  requires n == 11
  ensures Int.pow(1/4, n+1) * Int.pow(2, 2*n) == 1/4
{}