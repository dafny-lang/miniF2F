include "../utils.dfy"

import opened Utils

lemma mathd_algebra_11(a: real, b: real)
  requires a != b
  requires a != 2.0*b
  requires 4.0*a + 3.0*b / (a - 2.0*b) == 5.0
  ensures (a + 11.0*b) / (a - b) == 2.0
{}