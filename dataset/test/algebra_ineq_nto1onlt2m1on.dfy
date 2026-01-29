include "../definitions.dfy"
include "../library.dfy"

lemma algebra_ineq_nto1onlt2m1on(n: nat)
  requires n > 1
  ensures Real.rpow(n as real, 1.0/(n as real)) < 2.0 - 1.0/(n as real)
{}