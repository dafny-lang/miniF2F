include "../utils.dfy"

import opened Utils

lemma imo_1990_p3(n: nat)
  requires 2 <= n
  requires power(n, 2) % power(2, n) + 1 == 0
  ensures n == 3
{
  assert power(n, 2) % power(2, n) + 1 == 0;
  assert n % power(2, n) == 0;
  assert n % power(2, n) + 1 == 1;
  assert power(2, n) == n;
  assert n == 2 || n == 3;
  if n == 2 {
    assert power(2, n) != n;
  }
  assert n != 2;
  assert n == 3;
}