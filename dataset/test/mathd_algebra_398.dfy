include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_398(a: real, b: real, c: real)
  requires 0.0 < a
  requires 0.0 < b
  requires 0.0 < c
  requires 9.0 * b == 20.0 * c
  requires 7.0 * a == 4.0 * b
  ensures 63.0 * a == 80.0 * c
{}