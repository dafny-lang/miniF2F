include "../utils.dfy"

import opened Utils

lemma mathd_algebra_126(x: real, y: real)
  requires 2.0 * 3.0 == x - 9.0
  requires 2.0 * (-5.0) == y + 1.0
  ensures x == 15.0
  ensures y == -11.0
{}