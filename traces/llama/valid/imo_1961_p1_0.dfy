include "../utils.dfy"

import opened Utils

lemma imo_1961_p1(x: real, y: real, z: real, a: real, b: real)
  requires 0.0 < x
  requires 0.0 < y
  requires 0.0 < z
  requires x != y
  requires y != z
  requires z != x
  requires x + y + z == a
  requires x*x + y*y + z*z == b*b
  requires x*y == z*z
  ensures 0.0 < a
  ensures b*b < a*a
  ensures a*a < 3.0 * b*b
{}