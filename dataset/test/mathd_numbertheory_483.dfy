include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_483(a: nat -> nat)
  requires a(1) == 1
  requires a(2) == 1
  requires forall n: nat :: a(n+2) == a(n+1) + a(n)
  ensures a(100) % 4 == 3
{}