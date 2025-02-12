include "../utils.dfy"

import opened Utils

lemma mathd_algebra_513(a: real, b: real)
  requires 3.0*a + 2.0*b == 5.0
  requires a+b == 2.0
  ensures a == 1.0
  ensures b == 1.0
{}