include "../definitions.dfy"
include "../library.dfy"

lemma amc12b_2002_p11(a: nat, b: nat)
  requires prime(a)
  requires prime(b)
  requires prime(a+b)
  requires prime(a-b)
  ensures prime(a + b + a - b + a + b)
{}