include "../utils.dfy"

import opened Utils

lemma amc12b_2003_p9(a: real, b: real, f: real -> real)
  requires forall x :: f(x) == a*x + b
  requires f(6.0) - f(2.0) == 12.0
  ensures f(12.0) - f(2.0) == 30.0
{}