// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12b_2003_p6(a: real, r: real, u: nat -> real)
  requires forall k:: u(k) == a * Real.pow(r, k)
  requires u(1) == 2.0
  requires u(3) == 6.0
  ensures u(0) == 2.0/sqrt(3.0) || u(0) == -(2.0 / sqrt(3.0))
{}