include "../utils.dfy"

import opened Utils

lemma mathd_algebra_104(x: real)
  requires 125.0 / 8.0 == x / 12.0
  ensures x == 375.0 / 2.0
{}