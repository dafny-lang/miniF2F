// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_480(f: real -> real)
  requires forall x | x < 0.0 :: f(x) == -(x*x) - 1.0
  requires forall x | 0.0 <= x < 4.0 :: f(x) == 2.0
  requires forall x | x >= 4.0 :: f(x) == sqrt(x)
  ensures f(pi) == 2.0
{}