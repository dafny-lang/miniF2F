include "../utils.dfy"

import opened Utils

lemma mathd_algebra_137(x: nat)
  requires (x as real) + 4.0 / 100.0 * (x as real) == 598 as real
  ensures x == 575
{}