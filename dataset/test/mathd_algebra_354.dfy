include "../utils.dfy"

import opened Utils

lemma mathd_algebra_354(a: real, d: real)
  requires a + 6.0*d == 30.0
  requires a + 10.0*d == 60.0
  ensures a + 20.0*d == 135.0
{}