// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_288(x: real, y: real, n: real)
  requires n >= 0.0
  requires x < 0.0
  requires y < 0.0
  requires abs(x) == 6.0
  requires sqrt(Real.pow(x - 8.0, 2) + Real.pow(y - 3.0, 2)) == 15.0
  requires sqrt(x*x + y*y) == sqrt(n)
  ensures n == 52.0
{}