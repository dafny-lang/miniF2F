// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_437(x: real, y: real, n: int)
  requires x*x*x == -45.0
  requires y*y*y == -101.0
  requires x < (n as real)
  requires (n as real) < y
  ensures n == -4
{}