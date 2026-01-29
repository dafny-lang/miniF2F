include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_422(x: real, f: real -> real, g: real -> real)
  requires forall x :: f(g(x)) == x
  requires forall x :: g(f(x)) == x
  requires forall x :: f(x) == 5.0*x - 12.0
  requires f(x+1.0) == g(x)
  ensures x == 47.0/24.0
{}