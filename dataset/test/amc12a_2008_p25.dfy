include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2008_p25(a: nat -> real, b: nat -> real)
  requires forall n: nat :: a(n+1) == sqrt(3.0 * a(n) - b(n))
  requires forall n: nat :: b(n+1) == sqrt(3.0 * b(n) + a(n))
  requires a(100) == 2.0
  requires b(100) == 4.0
  ensures a(1) + b(1) == 1.0/Real.pow(2.0, 98)
{}