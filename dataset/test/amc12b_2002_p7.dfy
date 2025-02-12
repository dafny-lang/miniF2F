include "../utils.dfy"

import opened Utils

lemma amc12b_2002_p7(a: nat, b: nat, c: nat)
  requires 0 < a 
  requires 0 < b
  requires 0 < c
  requires b == a + 1
  requires c == b + 1
  requires a*b*c == 8*(a+b+c)
  ensures a*a + b*b + c*c == 77
{}