include "../utils.dfy"

import opened Utils

lemma mathd_algebra_153(n: real)
  requires n == 1.0 / 3.0
  ensures (10.0*n).Floor + (100.0*n).Floor + (1000.0*n).Floor + (10000.0*n).Floor == 3702
{}