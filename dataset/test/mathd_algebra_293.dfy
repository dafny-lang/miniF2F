// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_293(x: real)
  requires x >= 0.0
  ensures sqrt(60.0*x) * sqrt(12.0*x) * sqrt(63.0*x) == 36.0*x*sqrt(35.0*x)
{}