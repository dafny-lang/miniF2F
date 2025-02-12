include "../utils.dfy"

import opened Utils

lemma induction_seq_mul2pnp1(n: nat, u: nat -> nat)
  requires u(0) == 0
  requires forall n: nat :: u(n+1) == 2* u(n) + n+1
  ensures u(n) == power(2, n+1) - (n+2)
{}