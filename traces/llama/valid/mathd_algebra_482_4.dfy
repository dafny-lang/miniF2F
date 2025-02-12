include "../utils.dfy"

import opened Utils

lemma mathd_algebra_482(m: nat, n: nat, k: real, f: real -> real)
  requires prime(m)
  requires prime(n)
  requires forall x :: f(x) == x*x - 12.0 *x + k
  requires f(m as real) == 0.0
  requires f(n as real) == 0.0
  requires m != n
  ensures k == 35.0
 {
    f(m as real) == m*m - 12.0 * m + k == 0.0;
    f(n as real) == n*n - 12.0 * n + k == 0.0;
    m*m - 12.0 * m == n*n - 12.0 * n;
    m*m - n*n == 12.0 * m - 12.0 * n;
    (m - n) * (m + n) == 12.0 * (m - n);
    m + n == 12.0;
    m == 5;
    n == 7;
    k == 35.0;
  }