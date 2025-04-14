// Author: Stefan Zetzsche

include "../utils.dfy"

lemma imo_1969_p2(m: real, n: real, k: nat, a: nat -> real, f: real -> real)
  requires 0 < k
  requires forall x :: f(x) == Real.sum(range(k), (i: int) => cos(a(i)+x) / (Int.pow(2,i) as real))
  requires f(m) == 0.0
  requires f(n) == 0.0
  ensures exists t: int :: m-n == (t as real) * pi
{}