include "../utils.dfy"

import opened Utils

lemma amc12_2000_p20(x: real, y: real, z: real)
  requires 0.0 < x
  requires 0.0 < y
  requires 0.0 < z
  requires x + 1.0/y == 4.0
  requires y + 1.0/z == 1.0
  requires z + 1.0/x == 7.0/3.0
  ensures x*y*z == 1.0
{}