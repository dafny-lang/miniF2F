include "../utils.dfy"

lemma imo_1987_p6(p: nat, f: nat -> nat)
  requires forall x: nat :: f(x) == x*x + x + p
  requires forall k: nat | k <= sqrt((p as real)/3.0).Floor :: prime(f(k))
  ensures forall i: nat | i <= p-2 :: prime(f(i))
{}