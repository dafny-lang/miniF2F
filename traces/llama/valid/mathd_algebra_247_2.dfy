include "../utils.dfy"

import opened Utils

lemma mathd_algebra_247(t: real, s: real, n: int)
  requires t == 2.0 * s - s * s
  requires s == n as real * n as real - power(2, n) as real + 1.0
  requires n == 3
  ensures t == 0.0
{
  assert s == 3.0 * 3.0 - power(2, 3) as real + 1.0;
  assert s == 9.0 - 8.0 + 1.0;
  assert s == 2.0;
  assert t == 2.0 * s - s * s;
  assert t == 2.0 * 2.0 - 2.0 * 2.0;
  assert t == 4.0 - 4.0;
  assert t == 0.0;
}