// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12a_2010_p10(p: real, q: real, a: nat -> real)
  requires forall n: nat :: a(n+2) - a(n+1) == a(n+1) - a(n)
  requires a(1) == p
  requires a(2) == 9.0
  requires a(3) == 3.0*p - 1.0
  requires a(4) == 3.0*p + q
  ensures a(2010) == 8041.0
{}
