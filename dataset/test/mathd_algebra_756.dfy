// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_756(a: real, b: real)
  requires Real.rpow(2.0, a) == 32.0
  requires Real.rpow(a, b) == 125.0
  ensures Real.rpow(b, a) == 243.0
{}