include "../utils.dfy"

lemma mathd_algebra_143(f: real -> real, g: real -> real)
  requires forall x :: f(x) == x + 1.0
  requires forall x :: g(x) == x*x + 3.0
  ensures f(g(2.0)) == 8.0
{}