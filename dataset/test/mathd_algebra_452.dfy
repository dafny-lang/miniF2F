// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_452(a: nat -> real)
  requires forall n: nat {:trigger a(n)} :: a(n+2) - a(n+1) == a(n+1) - a(n)
  requires a(1) == 2.0 / 3.0
  requires a(9) == 4.0 / 5.0
  ensures a(5) == 11.0 / 15.0
{}