// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_275(x: real)
  requires Real.rpow(Real.rpow(11.0, 1.0/(4 as real)), 3.0*x - 3.0) == 1.0/5.0
  ensures Real.rpow(Real.rpow(11.0, 1.0/(4 as real)), 6.0*x + 2.0) == 121.0/25.0
{}