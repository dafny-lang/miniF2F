include "../utils.dfy"

import opened Utils

lemma imo_1964_p2(a: real, b: real, c: real)
  requires 0.0 < a
  requires 0.0 < b
  requires 0.0 < c
  requires c < a + b
  requires b < a + c
  requires a < b + c
  ensures a*a*(b+c-a) + b*b*(c+a-b) + c*c*(a+b-c) <= 3.0*a*b*c
{}