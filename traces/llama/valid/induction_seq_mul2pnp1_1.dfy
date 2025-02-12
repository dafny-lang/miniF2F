include "../utils.dfy"

import opened Utils

lemma induction_seq_mul2pnp1(n: nat, u: nat -> nat)
  requires u(0) == 0
  requires forall n: nat :: u(n+1) == 2* u(n) + n+1
  ensures u(n) == power(2, n+1) - (n+2)
 ```dafny
  {
    var i := 0;
    while i <= n
      invariant u(i) == 2 * i - 1
      invariant i <= n
    {
      if i == n { break; }
      assert u(i+1) == 2 * u(i) + (i+1);
      assert u(i+1) == 2 * (2 * i - 1) + (i+1);
      assert u(i+1) == 4 * i - 2 + i + 1;
      assert u(i+1) == 5 * i - 1;
      assert u(i+1) == 2 * (i+1) - 1;
      i := i + 1;
    }
    assert u(n) == 2 * n - 1;
    assert 2 * n - 1 == power(2, n+1) - (n+2);
  }
```