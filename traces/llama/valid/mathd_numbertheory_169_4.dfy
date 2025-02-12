include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_169()
  ensures gcd(factorial(20), 200000) == 40000
{
  assert factorial(20) % 40000 == 0;
  assert 200000 % 40000 == 0;
  var p := 1;
  while p <= factorial(20) && p <= 200000
    invariant p > 0
    invariant p <= factorial(20)
    invariant p <= 200000
  {
    if factorial(20) % p == 0 && 200000 % p == 0 {
      assert p <= 40000;
    }
    p := p + 1;
  }
}