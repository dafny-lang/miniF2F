// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma imo_1960_p2(x: real)
  requires Real.pow(1.0 - sqrt(1.0 + 2.0*x), 2) != 0.0
  requires 4.0*x*x / Real.pow(1.0 - sqrt(1.0 + 2.0*x), 2) < 2.0*x + 9.0
  ensures -0.5 <= x < 45.0/8.0
{}