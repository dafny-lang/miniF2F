// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma aime_1990_p4(x: real)
  requires 0.0 < x
  requires x*x - 10.0*x - 29.0 != 0.0
  requires x*x - 10.0*x - 45.0 != 0.0
  requires x*x - 10.0*x - 69.0 != 0.0
  requires 1.0/(x*x - 10.0*x - 29.0) + 1.0/(x*x - 10.0*x - 45.0) - 2.0/(x*x - 10.0*x - 69.0) == 0.0
  ensures x == 13.0
{}