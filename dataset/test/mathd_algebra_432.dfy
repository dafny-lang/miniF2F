include "../utils.dfy"

import opened Utils

lemma mathd_algebra_432(x: real)
  ensures (x+3.0) * (2.0*x - 6.0) == 2.0*x*x - 18.0
{}