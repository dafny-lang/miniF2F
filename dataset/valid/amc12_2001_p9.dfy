include "../utils.dfy"

import opened Utils

lemma amc12_2001_p9(f: real -> real)
  requires forall x,y | x > 0.0 && y > 0.0 :: f(x*y) == f(x)/y
  requires f(500.0) == 3.0
  ensures f(600.0) == 5.0 / 2.0
{}