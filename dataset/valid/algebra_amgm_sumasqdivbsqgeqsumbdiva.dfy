// Author: Stefan Zetzsche

include "../utils.dfy"

lemma algebra_amgm_sumasqdivbsqgeqsumbdiva(a: real, b: real, c: real)
  requires 0.0 < a
  requires 0.0 < b
  requires 0.0 < c
  ensures 0.0 != b*b
  ensures 0.0 != c*c
  ensures 0.0 != a*a
  ensures (a*a)/(b*b) + (b*b)/(c*c) + (c*c)/(a*a) >= b/a + c/b + a/c
{}