// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma algebra_amgm_prod1toneq1_sum1tongeqn(a: nat -> real, n: nat)
  requires Real.prod(range(n), k => a(k)) == 1.0
  ensures Real.sum(range(n), k => a(k)) >= n as real
{}