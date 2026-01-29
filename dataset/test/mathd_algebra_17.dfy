include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_17(a: real)
  requires sqrt(4.0 + sqrt(16.0 + 16.0*a)) + sqrt(1.0 + sqrt(1.0+a)) == 6.0
  ensures a == 8.0
{}