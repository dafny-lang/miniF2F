// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma induction_seq_mul2pnp1(n: nat, u: nat -> nat)
  requires u(0) == 0
  requires forall n: nat :: u(n+1) == 2*u(n) + n+1
  ensures u(n) == Int.pow(2, n+1) - (n+2)
{}