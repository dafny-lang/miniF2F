include "../utils.dfy"

import opened Utils

lemma amc12a_2017_p7(f: nat -> real)
  requires f(1) == 2.0
  requires forall n :: 1 < n && n % 2 == 0 ==> f(n) == f(n-1) + 1.0
  requires forall n :: 1 < n && n % 2 == 1 ==> f(n) == f(n-2) + 2.0
  ensures f(2017) == 2018.0
{
  var n := 2017;
  assert f(1) == 2.0;
  while n > 1
    invariant f(1) == 2.0
    invariant 1 < n
    invariant n % 2 == 1
    decreases n
  {
    if n % 2 == 0 {
      assert f(n) == f(n-1) + 1.0;
      n := n-1;
    } else {
      assert f(n) == f(n-2) + 2.0;
      n := n-2;
    }
  }
  assert n == 1;
  assert f(1) == 2.0;
  assert f(2017) == 2018.0;
}