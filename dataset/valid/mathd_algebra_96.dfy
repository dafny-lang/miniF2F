// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_96(x: real, y: real, z: real, a: real)
  requires 0.0 < x
  requires 0.0 < y
  requires 0.0 < z
  requires log(x) - log(y) == a
  requires log(y) - log(z) == 15.0
  requires log(z) - log(x) == -7.0
  ensures a == -8.0
{}