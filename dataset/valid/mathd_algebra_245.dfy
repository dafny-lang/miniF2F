// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_245(x: real)
  requires x != 0.0
  ensures 1.0/(4.0/x) * Real.pow((3.0*x*x*x)/x, 2) * Real.pow(1.0/(1.0/(2.0*x)), 3) == 18.0 * Real.pow(x, 8)
{}