include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_153(n: real)
  requires n == 1.0 / 3.0
  ensures floor(10.0*n) + floor(100.0*n) + floor(1000.0*n) + floor(10000.0*n) == 3702
{}