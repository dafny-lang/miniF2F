// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12_2001_p2(a: nat, b: nat, n: nat)
  requires 1 <= a <= 9
  requires 0 <= b <= 9
  requires n == 10*a + b
  requires n == a*b + a + b
  ensures b == 9
{}