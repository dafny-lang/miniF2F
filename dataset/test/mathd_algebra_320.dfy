// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_320(x: real, a: nat, b: nat, c: nat)
  requires x >= 0.0
  requires a > 0
  requires b > 0
  requires c > 0
  requires 2.0 * x * x == 4.0 * x + 9.0
  requires x == (a as real + sqrt(b as real)) / (c as real)
  ensures a + b + c == 26
{}