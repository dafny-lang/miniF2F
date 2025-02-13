include "../utils.dfy"

lemma amc12a_2017_p7(f: nat -> real)
  requires f(1) == 2.0
  requires forall n :: 1 < n && n % 2 == 0 ==> f(n) == f(n-1) + 1.0
  requires forall n :: 1 < n && n % 2 == 1 ==> f(n) == f(n-2) + 2.0
  ensures f(2017) == 2018.0
{}