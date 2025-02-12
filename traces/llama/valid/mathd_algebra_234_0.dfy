include "../utils.dfy"

import opened Utils

lemma mathd_algebra_234(d: real)
  requires 27.0 / 125.0 * d == 9.0 / 25.0
  ensures 3.0 / 5.0 * d*d*d == 25.0 / 9.0
{}