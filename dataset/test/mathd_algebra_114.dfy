// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_114(a: real)
  requires a == 8.0
  ensures Real.rpow(16.0 * Real.rpow(a*a, 1.0/(3 as real)), 1.0/(3 as real)) == 4.0
{}