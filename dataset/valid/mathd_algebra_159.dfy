// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_159(b: real, f: real -> real)
  requires forall x :: f(x) == 3.0*x*x*x*x - 7.0*x*x*x + 2.0*x*x - b*x + 1.0
  requires f(1.0) == 1.0
  ensures b == -2.0
{}