include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2009_p25(a: nat -> real)
  requires a(1) == 1.0
  requires a(2) == 1.0 / sqrt(3.0)
  requires forall n | 1 <= n :: 1.0 - a(n)*a(n+1) != 0.0 && a(n+2) == (a(n) + a(n+1)) / (1.0 - a(n)*a(n+1))
  ensures Real.abs(a(2009)) == 0.0
{}