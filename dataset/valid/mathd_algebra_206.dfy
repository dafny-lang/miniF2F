include "../utils.dfy"

import opened Utils

lemma mathd_algebra_206(a: real, b: real, f: real -> real)
  requires forall x :: f(x) == x*x + a*x + b
  requires 2.0 * a != b
  requires f(2.0 * a) == 0.0
  requires f(b) == 0.0
  ensures a + b == -1.0
{}