// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_441(x: real)
  requires x != 0.0
  ensures 12.0 / x*x * (x*x*x*x/(14.0/x)) * (35.0/3.0*x) == 10.0
{}