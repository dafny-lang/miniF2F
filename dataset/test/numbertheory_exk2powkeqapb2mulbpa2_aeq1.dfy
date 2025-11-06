// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma numbertheory_exk2powkeqapb2mulbpa2_aeq1(a: nat, b: nat)
  requires 0 < a
  requires 0 < b
  requires exists k: nat | k > 0 :: Int.pow(2, k) == (a + b*b) * (b + a*a)
  ensures a == 1
{}