include "../definitions.dfy"
include "../library.dfy"

lemma induction_nfactltnexpnm1ngt3(n: nat)
  requires 3 <= n
  ensures factorial(n) < Int.pow(n, n-1)
{}