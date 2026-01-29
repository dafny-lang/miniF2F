include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_427(x: real, y: real, z: real)
  requires 3.0*x + y == 17.0
  requires 5.0*y + z == 14.0
  requires 3.0*x + 5.0*z == 41.0
  ensures x + y + z == 12.0
{}
