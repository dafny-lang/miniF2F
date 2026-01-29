include "../definitions.dfy"
include "../library.dfy"

lemma algebra_9onxpypzleqsum2onxpy(x: real, y: real, z: real)
  requires 0.0 < x
  requires 0.0 < y
  requires 0.0 < z
  ensures 9.0/(x+y+z) <= 2.0/(x+y) + 2.0/(y+z) + 2.0/(z+x)
{}