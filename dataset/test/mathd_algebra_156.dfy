include "../utils.dfy"

lemma mathd_algebra_156(x: real, y: real, f: real -> real, g: real -> real)
  requires forall t :: f(t) == t*t*t*t
  requires forall t :: g(t) == 5.0*t*t - 6.0
  requires f(x) == g(x)
  requires f(y) == g(y)
  requires x*x < y*y
  ensures y*y - x*x == 1.0
{}