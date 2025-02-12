include "../utils.dfy"

import opened Utils

lemma mathd_algebra_455(x: real)
  requires 2.0*2.0*2.0*2.0*x == 48.0
  ensures x == 3.0
{}