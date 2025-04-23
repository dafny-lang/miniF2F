// Author: Stefan Zetzsche

include "../utils.dfy"

lemma imo_1966_p4(n: nat, x: real)
  requires forall k | 0 < k :: (forall m: int :: x != (m as real) * pi() / Real.pow(2.0, k))
  requires 0 < n
  ensures Real.sum(set k | 1 <= k <= n :: k, k => 1.0/(sin(Real.pow(2.0, k)*x))) == 1.0/tan(x) - 1.0/tan(Real.pow(2.0, n)*x)
{}