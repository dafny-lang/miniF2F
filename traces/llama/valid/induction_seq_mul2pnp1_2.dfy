include "../utils.dfy"

import opened Utils

lemma induction_seq_mul2pnp1(n: nat, u: nat -> nat)
  requires u(0) == 0
  requires forall n: nat :: u(n+1) == 2* u(n) + n+1
  ensures u(n) == power(2, n+1) - (n+2)
{
  if n == 0 {
    assert u(0) == 0;
    assert power(2, 0+1) - (0+2) == 2 - 2 == 0;
  } else {
    induction_seq_mul2pnp1(n-1, u);
    assert u(n) == 2 * u(n-1) + n;
    assert u(n-1) == power(2, n) - (n+1);
    assert u(n) == 2 * (power(2, n) - (n+1)) + n;
    assert u(n) == power(2, n+1) - 2 * (n+1) + n;
    assert u(n) == power(2, n+1) - (n+2);
  }
}