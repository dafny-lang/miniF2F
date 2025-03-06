// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_393(f: real -> real, g: real -> real)
  requires forall x :: f(g(x)) == x
  requires forall x :: g(f(x)) == x
  requires forall x :: f(x) == 4.0*x*x*x + 1.0
  ensures g(33.0) == 2.0
{}