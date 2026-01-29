include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_323(f: real -> real, g: real -> real)
  requires forall x :: f(g(x)) == x
  requires forall x :: g(f(x)) == x
  requires forall x :: f(x) == x*x*x - 8.0
  ensures g(f(g(19.0))) == 3.0
{}