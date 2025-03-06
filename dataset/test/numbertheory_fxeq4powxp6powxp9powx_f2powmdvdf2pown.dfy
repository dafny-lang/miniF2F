// Author: Stefan Zetzsche

include "../utils.dfy"

lemma numbertheory_fxeq4powxp6powxp9powx_f2powmdvdf2pown(m: nat, n: nat, f: nat -> nat)
  requires forall x :: f(x) == Int.pow(4, x) + Int.pow(6, x) + Int.pow(9, x)
  requires 0 < m && 0 < n
  requires m <= n
  ensures f(Int.pow(2, n)) % f(Int.pow(2, m)) == 0
{}