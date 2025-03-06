// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_270(f: real -> real)
  requires forall x: real | x != -2.0 :: f(x) == 1.0/(x + 2.0)
  ensures f(f(1.0)) == 3.0/7.0
{}