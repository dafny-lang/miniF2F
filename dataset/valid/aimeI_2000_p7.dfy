// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma aimeI_2000_p7(x: real, y: real, z: real, m: rat)
  requires 0.0 < x
  requires 0.0 < y
  requires 0.0 < z
  requires 0.0 < m.to_real()
  requires x*y*z == 1.0
  requires x + 1.0/z == 5.0
  requires y + 1.0/x == 29.0
  requires z + 1.0/y == m.to_real()
  ensures m.denom + m.num == 5
{}