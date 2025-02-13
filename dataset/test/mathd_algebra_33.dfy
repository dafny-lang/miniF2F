include "../utils.dfy"

lemma mathd_algebra_33(x: real, y: real, z: real)
  requires x != 0.0
  requires 2.0 * x == 5.0 * y
  requires 7.0 * y == 10.0 * z
  ensures z / x == 7.0 / 25.0
{}