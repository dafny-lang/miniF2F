include "../utils.dfy"

import opened Utils

lemma amc12b_2002_p6(a: real, b: real)
  requires a != 0.0
  requires b != 0.0
  requires forall x :: x*x + a*x + b == (x-a)*(x-b)
  ensures a == 1.0
  ensures b == -2.0
{
  var x := 0.0;
  assert x*x + a*x + b == (x-a)*(x-b);
  assert 0.0 + 0.0 + b == (0.0-a)*(0.0-b);
  assert b == a*b;
  assert a == 1.0 || b == 0.0;
  assert a != 1.0;
  assert b != 0.0;
  assert false;
}