// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_37(x: real, y: real)
  requires x + y == 7.0
  requires 3.0*x + y == 45.0
  ensures x*x - y*y == 217.0
{}