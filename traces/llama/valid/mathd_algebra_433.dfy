include "../utils.dfy"

import opened Utils

// added x >= 3.5
lemma mathd_algebra_433(f: real -> real)
  requires forall x | x >= 3.5 :: f(x) == 3.0*sqrt(2.0*x - 7.0) - 8.0
  ensures f(8.0) == 1.0
{}