// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_598(a: real, b: real, c: real, d: real)
  requires Real.rpow(4.0, a) == 5.0
  requires Real.rpow(5.0, b) == 6.0
  requires Real.rpow(6.0, c) == 7.0
  requires Real.rpow(7.0, d) == 8.0
  ensures a*b*c*d == 3.0/2.0
{}