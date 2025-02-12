include "../utils.dfy"

import opened Utils

lemma imo_1964_p1_1(n: nat)
  requires n != 0 // added this manually
  requires 7 % (power(2, n) - 1) == 0
  ensures 3 % n == 0
{
  var k := (power(2, n) - 1) / 7;
  assert k * 7 == power(2, n) - 1;
  assert k * 7 + 1 == power(2, n);
  assert power(2, n) % 7 == 1;
  assert power(2, 3) % 7 == 1;
  assert n % 3 == 0;
}