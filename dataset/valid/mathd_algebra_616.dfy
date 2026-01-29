include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_616(f: real -> real, g: real -> real)
  requires forall x :: f(x) == x*x*x + 2.0*x + 1.0
  requires forall x :: g(x) == x - 1.0
  ensures f(g(1.0)) == 1.0
{}