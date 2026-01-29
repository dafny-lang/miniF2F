include "../definitions.dfy"
include "../library.dfy"

lemma induction_prod1p1onk3le3m1onn(n: nat)
  requires 0 < n
  ensures Real.prod(set k: int | 1 <= k <= n, (k: int) => if k < 1 then 0.0 else 1.0 + 1.0/((k*k*k) as real)) <= 3.0 - 1.0/(n as real)
{}