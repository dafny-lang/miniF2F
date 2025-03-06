// Author: Stefan Zetzsche

include "../utils.dfy"

lemma imo_1985_p6(f: nat -> real -> real)
  requires forall x: real | x >= 0.0 :: f(1)(x) == x as real
  requires forall x: real, n: nat | x >= 0.0 :: f(n+1)(x) == f(n)(x) * f(n)(x) + 1.0/(n as real)
  ensures exists a: real | a >= 0.0 :: (forall n: nat | 0 < n :: 0.0 < f(n)(a) < f(n+1)(a) < 1.0)
{}