// Author: Stefan Zetzsche

include "../utils.dfy"

lemma algebra_ineq_nto1onlt2m1on(n: nat)
  requires n != 0
  ensures Real.rpow(n as real, 1.0/(n as real)) < 2.0 - 1.0/(n as real)
{}