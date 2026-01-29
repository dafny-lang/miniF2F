include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2013_p7(s: nat -> real)
  requires forall n: nat :: s(n+2) == s(n+1) + s(n)
  requires s(9) == 110.0
  requires s(7) == 42.0
  ensures s(4) == 10.0
{}