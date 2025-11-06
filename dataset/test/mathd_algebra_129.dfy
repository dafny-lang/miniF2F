// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_129(a: real)
  requires a != 0.0
  requires (1.0/8.0) / (1.0/4.0) - (1.0/a) == 1.0
  ensures a == -2.0
{}