// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_510(x: real, y: real)
  requires x + y == 13.0
  requires x * y == 24.0
  requires sqrt(x*x + y*y) == 11.0
{}