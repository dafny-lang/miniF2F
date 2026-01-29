include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_101(x: real)
  requires x*x - 5.0*x -4.0 <= 10.0
  ensures -2.0 <= x <= 7.0
{}