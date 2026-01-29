include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_451(f: real -> real, g: real -> real)
  requires forall x :: f(g(x)) == x
  requires forall x :: g(f(x)) == x
  requires g(-15.0) == 0.0
  requires g(0.0) == 3.0
  requires g(3.0) == 9.0
  requires g(9.0) == 20.0
  ensures f(f(9.0)) == 0.0
{}