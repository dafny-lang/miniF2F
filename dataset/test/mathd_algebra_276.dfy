include "../utils.dfy"

import opened Utils

lemma mathd_algebra_276(a: int, b: int)
  requires forall x: real :: 10.0*x*x - x - 24.0 == ((a as real)*x - 8.0) * ((b as real)*x + 3.0)
  ensures a + b == 12
{}