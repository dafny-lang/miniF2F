include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_156(n: nat)
  requires 0 < n
  ensures gcd(n+7, 2*n+1) <= 13
{
  var a := gcd(n+7, 2*n+1);
  assert a > 0;
  assert (n+7) % a == 0;
  assert (2*n+1) % a == 0;
  if a > 13 {
    assert (n+7) % 13 == 0;
    assert (2*n+1) % 13 == 0;
    assert (2*n+1 - 2*(n+7)) % 13 == 0;
    assert -15 % 13 == 0;
    assert false;
  }
}