// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12a_2003_p1(u: nat -> nat, v: nat -> nat)
  requires forall n :: u(n) == 2*n + 2
  requires forall n :: v(n) == 2*n + 1
  ensures Int.sum(range(2003), k => u(k)) - Int.sum(range(2003), k => v(k)) == 2003
{}