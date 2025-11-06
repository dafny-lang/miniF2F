// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2009_p7(x: real, n: nat, a: nat -> real)
  requires forall m: nat :: a(m+1) - a(m) == a(m+2) - a(m+1)
  requires a(1) == 2.0*x - 3.0
  requires a(2) == 5.0*x - 11.0
  requires a(3) == 3.0*x + 1.0
  requires a(n) == 2009.0
  ensures n == 502
{}