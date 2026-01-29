include "../definitions.dfy"
include "../library.dfy"

lemma imo_1978_p5(n: nat, a: nat -> nat)
  requires forall m :: 0 < a(m)
  requires forall p, q | p != q :: a(p) != a(q)
  requires 0 < n
  ensures Real.sum(set k | 1 <= k <= n :: k, k => if k <= 0 then 0.0 else 1.0/(k as real)) <= Real.sum(set k | 1 <= k <= n :: k, k => if k <= 0 then 0.0 else (a(k) as real)/((k as real)*(k as real)))
{}