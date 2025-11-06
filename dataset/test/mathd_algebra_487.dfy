// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_487(a: real, b: real, c: real, d: real)
  requires b == a*a
  requires a+b == 1.0
  requires d == c*c
  requires c + d == 1.0
  ensures sqrt((a-c)*(a-c) + (b-d)*(b-d)) == sqrt(10.0)
{}