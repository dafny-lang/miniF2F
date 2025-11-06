// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_435(k: nat)
  requires 0 < k
  requires forall n: nat :: gcd(6*n + k, 6*n + 3) == 1
  requires forall n: nat :: gcd(6*n + k, 6*n + 2) == 1
  requires forall n: nat :: gcd(6*n + k, 6*n + 1) == 1
  ensures 5 <= k
{}