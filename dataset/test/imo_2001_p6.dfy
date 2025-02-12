include "../utils.dfy"

import opened Utils

lemma imo_2001_p6(a: nat, b: nat, c: nat, d: nat)
  requires 0 < a
  requires 0 < b
  requires 0 < c
  requires 0 < d
  requires d < c < b < a
  requires a*c + b*d == (b+d+a-c)*(b+d-a+c)
  ensures !prime(a*b + c*d)
{}