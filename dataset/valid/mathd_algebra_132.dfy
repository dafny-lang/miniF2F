include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_132(x: real, f: real -> real, g: real -> real)
  requires forall x :: f(x) == x + 2.0
  requires forall x :: g(x) == x*x
  requires f(g(x)) == g(f(x))
  ensures x == -1.0/2.0
{}