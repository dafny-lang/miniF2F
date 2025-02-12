include "../utils.dfy"

import opened Utils

lemma imo_1990_p3(n: nat)
  requires 2 <= n
  requires power(n, 2) % power(2, n) + 1 == 0
  ensures n == 3
{
  assert power(n, 2) % power(2, n) + 1 == 0;
  assert n % 2 == 1;
  assert n == 3;
}