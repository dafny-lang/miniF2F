include "../utils.dfy"

import opened Utils

lemma mathd_algebra_338(a: real, b: real, c: real)
  requires 3.0*a + b + c == -3.0
  requires a + 3.0*b + c == 9.0
  requires a + b + 3.0*c == 19.0
  ensures a*b*c == -56.0
{}