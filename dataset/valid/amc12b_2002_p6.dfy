include "../utils.dfy"

import opened Utils

lemma amc12b_2002_p6(a: real, b: real)
  requires a != 0.0 
  requires b != 0.0
  requires forall x :: x*x + a*x + b == (x-a)*(x-b)
  ensures a == 1.0
  ensures b == -2.0
{}