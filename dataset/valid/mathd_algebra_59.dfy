// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_59(b: real)
  requires rpow(4.0, b) + rpow(2.0, 3.0) == 12.0
  ensures b == 1.0
{}