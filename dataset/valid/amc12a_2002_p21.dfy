include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2002_p21(u: nat -> nat)
  requires u(0) == 4
  requires u(1) == 7
  requires forall n | n >= 2 :: u(n+2) == (u(n) + (u(n+1))) % 10
  ensures forall n :: (Int.sum(range(n), k => u(k)) > 10000) ==> 1999 <= n
{}