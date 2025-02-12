include "../utils.dfy"

import opened Utils

lemma mathd_algebra_440(x: real)
  requires 3.0 / 2.0 / 3.0 == x / 1.0
  ensures x == 5.0
{}