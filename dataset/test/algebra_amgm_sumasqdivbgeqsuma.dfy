include "../definitions.dfy"
include "../library.dfy"

lemma algebra_amgm_sumasqdivbgeqsuma(a: real, b: real, c: real, d: real)
  requires 0.0 < a
  requires 0.0 < b
  requires 0.0 < c
  requires 0.0 < d
  ensures (a*a)/b + (b*b)/c + (c*c)/d + (d*d)/a >= a + b + c + d
{}