// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma algebra_amgm_sum1toneqn_prod1tonleq1(a: nat -> real, n: nat)
  requires Real.sum(range(n), k => a(k)) == n as real
  ensures Real.prod(range(n), k => a(k)) <= 1.0
{}