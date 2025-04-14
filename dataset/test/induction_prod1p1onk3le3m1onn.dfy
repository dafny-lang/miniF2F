// Author: Stefan Zetzsche

include "../utils.dfy"

lemma induction_prod1p1onk3le3m1onn(n: nat)
  requires 0 < n
  ensures Real.prod(set k: int | 1 <= k <= n, (k: int) => 1.0 + 1.0/((k*k*k) as real)) <= 3.0 - 1.0/(n as real)
{}