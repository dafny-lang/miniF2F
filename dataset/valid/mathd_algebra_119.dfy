include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_119(d: real, e: real)
  requires 2.0 * d == 17.0 * e - 8.0
  requires 2.0 * e == d - 9.0
  ensures e == 2.0
{}