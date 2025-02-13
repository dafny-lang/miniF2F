include "../utils.dfy"

lemma mathd_algebra_346(f: real -> real, g: real -> real)
  requires forall x :: f(x) == 2.0*x - 3.0
  requires forall x :: g(x) == x + 1.0
  ensures g(f(5.0) - 1.0) == 7.0
{}