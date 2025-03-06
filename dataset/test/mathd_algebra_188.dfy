// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_188(f: real -> real, g: real -> real)
  requires forall x :: f(g(x)) == x
  requires forall x :: g(f(x)) == x
  requires f(2.0) == g(2.0)
  ensures f(f(2.0)) == 2.0
{}