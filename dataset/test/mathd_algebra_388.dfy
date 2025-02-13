include "../utils.dfy"

lemma mathd_algebra_388(x: real, y: real, z: real)
  requires 3.0*x + 4.0*y - 12.0*z == 10.0
  requires -2.0*x - 3.0*y + 9.0*z == -4.0
  ensures x == 14.0
{}