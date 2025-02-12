include "../utils.dfy"

import opened Utils

lemma amc12a_2017_p7(f: nat -> real)
  requires f(1) == 2.0
  requires forall n :: 1 < n && n % 2 == 0 ==> f(n) == f(n-1) + 1.0
  requires forall n :: 1 < n && n % 2 == 1 ==> f(n) == f(n-2) + 2.0
  ensures f(2017) == 2018.0
{
  if f(1) == 2.0 {
    assert f(2) == f(1) + 1.0;
    assert f(3) == f(1) + 2.0;
    var n := 3;
    while n < 2017
      invariant f(n) == n + 1.0
    {
      if n % 2 == 0 {
        assert f(n+1) == f(n) + 1.0;
        assert f(n+1) == (n + 1.0) + 1.0;
      } else {
        assert f(n+1) == f(n-1) + 1.0;
        assert f(n-1) == (n-1) + 1.0;
        assert f(n+1) == (n-1) + 1.0 + 1.0;
        assert f(n+1) == n + 1.0 + 1.0;
      }
      n := n + 1;
    }
    assert f(2017) == 2017 + 1.0;
  }
}