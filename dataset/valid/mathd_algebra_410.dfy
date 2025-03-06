// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_410(x: real, y: real)
  requires y == x*x - 6.0*x + 13.0
  ensures 4.0 <= y
{}