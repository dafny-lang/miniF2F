include "../utils.dfy"

import opened Utils

lemma amc12a_2009_p9(a: real, b: real, c: real, f: real -> real)
  requires forall x: real :: f(x + 3.0) == 3.0 * x*x + 7.0 * x + 4.0
  requires forall x: real :: f(x) == a * x*x + b * x + c
  ensures a + b + c == 2.0
{}