include "../definitions.dfy"
include "../library.dfy"

lemma imo_1987_p6(p: nat, f: nat -> nat)
  requires forall x: nat :: f(x) == x*x + x + p
  requires forall k: nat | k <= floor(sqrt((p as real)/3.0)) :: prime(f(k))
  ensures forall i: nat | i <= p-2 :: prime(f(i))
{}