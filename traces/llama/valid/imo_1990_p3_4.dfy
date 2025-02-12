include "../utils.dfy"

import opened Utils

lemma imo_1990_p3(n: nat)
  requires 2 <= n
  requires power(n, 2) % power(2, n) + 1 == 0
  ensures n == 3
{
  assert power(n, 2) % power(2, n) + 1 == 0;
  assert n % 2 == 1; // n is odd
  var m := n - 1;
  assert m % 2 == 0; // m is even
  assert power(n, 2) % power(2, n) == -1;
  assert power(n, 2) % power(2, n) == (power(2, m) + 1) % power(2, n);
  assert power(2, m) % power(2, n) == -1;
  assert power(2, m) % power(2, n) == 0; // since m < n
  assert m == n - 1;
  assert n == 3;
}