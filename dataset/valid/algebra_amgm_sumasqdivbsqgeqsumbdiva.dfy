include "../utils.dfy"

import opened Utils

lemma algebra_amgm_sumasqdivbsqgeqsumbdiva(a: real, b: real, c: real)
  requires 0.0 < a
  requires 0.0 < b
  requires 0.0 < c
  ensures (a*a)/(b*b) + (b*b)/(c*c) + (c*c)/(a*a) >= b/a + c/b + a/c
{}