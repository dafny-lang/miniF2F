include "../utils.dfy"

import opened Utils

lemma numbertheory_fxeq4powxp6powxp9powx_f2powmdvdf2pown(m: nat, n: nat, f: nat -> nat)
  requires forall x :: f(x) == pow(4, x) + pow(6, x) + pow(9, x)
  requires 0 < m && 0 < n
  requires m <= n
  ensures f(pow(2, n)) % f(pow(2, m)) == 0
{}