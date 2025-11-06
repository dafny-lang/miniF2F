// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_141(a: real, b: real)
  requires a * b == 180.0
  requires 2.0 * (a + b) == 54.0
  ensures a*a + b*b == 369.0
{}