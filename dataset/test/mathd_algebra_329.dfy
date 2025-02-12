include "../utils.dfy"

import opened Utils

lemma mathd_algebra_329(x: real, y: real)
  requires 3.0*y == x
  requires 2.0*x + 5.0*y == 11.0
  ensures x + y == 4.0
{}