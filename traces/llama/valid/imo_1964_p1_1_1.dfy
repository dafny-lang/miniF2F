include "../utils.dfy"

import opened Utils

lemma imo_1964_p1_1(n: nat)
  requires n != 0 // added this manually
  requires 7 % (power(2, n) - 1) == 0
  ensures 3 % n == 0
{
  var p := power(2, n) - 1;
  assert 7 % p == 0;
  assert p % 7 == 0;
  assert 2 ^ n % 7 == 1;
  assert 2 ^ n % 7 == 1;
  var k := 0;
  while (2 ^ k % 7 != 1)
  {
    k := k + 1;
  }
  assert k > 0;
  assert 2 ^ k % 7 == 1;
  assert n % k == 0;
  assert k == 3;
  assert 3 % n == 0;
}