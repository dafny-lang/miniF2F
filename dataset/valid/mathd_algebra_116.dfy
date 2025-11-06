// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_116(k: real, x: real)
  requires x == (13.0 - sqrt(131.0)) / 4.0
  requires 2.0 * x*x - 13.0 * x + k == 0.0
  ensures k == 19.0/4.0
{}