// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_421(a: real, b: real, c: real, d: real)
  requires b == a*a + 4.0 * a + 6.0
  requires b == 1.0 / 2.0 * a*a + a + 6.0
  requires d == c*c + 4.0 * c + 6.0
  requires d == 1.0 / 2.0 * c*c + c + 6.0
  requires a <= c
  ensures c - a == 6.0
{}