// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma induction_sum_1oktkp1(n: nat)
  ensures Real.sum(range(n), k => 1.0/(((k as real)+1.0)*((k as real)+2.0))) == (n as real) / ((n as real) + 1.0)
{}