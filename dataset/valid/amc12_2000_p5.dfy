// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12_2000_p5(x: real, p: real)
  requires x < 2.0
  requires Real.abs(x-2.0) == p
  ensures x - p == 2.0 - 2.0*p
{}