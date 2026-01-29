include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_510(x: real, y: real)
  requires x + y == 13.0
  requires x * y == 24.0
  ensures sqrt(x*x + y*y) == 11.0
{}