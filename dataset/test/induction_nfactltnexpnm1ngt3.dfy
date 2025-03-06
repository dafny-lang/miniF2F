// Author: Stefan Zetzsche

include "../utils.dfy"

lemma induction_nfactltnexpnm1ngt3(n: nat)
  requires 3 <= n
  ensures factorial(n) < Int.pow(n, n-1)
{}