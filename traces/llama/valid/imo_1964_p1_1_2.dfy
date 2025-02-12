include "../utils.dfy"

import opened Utils

lemma imo_1964_p1_1(n: nat)
  requires n != 0 // added this manually
  requires 7 % (power(2, n) - 1) == 0
  ensures 3 % n == 0
{
  var m := power(2, n) - 1;
  assert 7 % m == 0;
  assert m % 7 == 0;
  var k := m / 7;
  assert k * 7 == m;
  assert k * 7 + 1 == power(2, n);
  assert k * 7 + 1 == 2 * power(2, n - 1);
  assert k * 7 == 2 * power(2, n - 1) - 1;
  assert 2 * power(2, n - 1) - 1 == k * 7;
  assert power(2, n - 1) % 7 == 3;
  assert power(2, n - 1) % 7 == 3;
  assert power(2, 3 * (n / 3)) % 7 == 1;
  assert power(2, n % 3) % 7 == 3;
  assert n % 3 == 1;
  assert n % 3 == 0 || n % 3 == 1 || n % 3 == 2;
  assert n % 3 == 1;
  assert n % 3 == 0;
}