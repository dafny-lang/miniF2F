include "../utils.dfy"

import opened Utils

lemma mathd_algebra_140(a: real, b: real, c: real)
  requires 0.0 < a
  requires 0.0 < b
  requires 0.0 < c
  requires forall x :: 24.0*x*x - 19.0*x - 35.0 == (a*x - 5.0) * (2.0*b*x + c)
  ensures a*b - 3.0*c == -9.0
{}