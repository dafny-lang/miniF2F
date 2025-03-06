// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_332(x: real, y: real)
  requires x >= 0.0
  requires y >= 0.0
  requires (x+y)/2.0 == 7.0
  requires (x*y >= 0.0) && sqrt(x*y) == sqrt(19.0)
  ensures x*x * y*y == 158.0
{}