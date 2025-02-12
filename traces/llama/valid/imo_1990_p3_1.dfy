include "../utils.dfy"

import opened Utils

lemma imo_1990_p3(n: nat)
  requires 2 <= n
  requires power(n, 2) % power(2, n) + 1 == 0
  ensures n == 3
{
  assert power(n, 2) % power(2, n) + 1 == 0;
  assert n % (power(2, n) + 1) == 0;
  assert n % (power(2, n) + 1) == 0;
  var k := n / (power(2, n) + 1);
  assert k * (power(2, n) + 1) == n;
  assert k == 0 || power(2, n) + 1 <= n;
  assert power(2, n) + 1 <= n;
  assert power(2, n) <= n - 1;
  assert n <= 3;
  assert n == 3;
}