include "../utils.dfy"

import opened Utils

lemma algebra_sqineq_2unitcircatblt1(a: real, b: real)
  requires a * a + b * b == 2.0
  ensures a * b <= 1.0
{
  assert a * a <= 2.0;
  assert b * b <= 2.0;
  assert (a * b) * (a * b) <= a * a * b * b;
  assert (a * b) * (a * b) <= 2.0 * b * b;
  assert (a * b) * (a * b) <= 2.0 * 2.0;
  assert (a * b) * (a * b) <= 4.0;
  assert a * b <= sqrt(4.0);
  assert a * b <= 2.0;
  assert a * b - 1.0 <= 1.0;
  assert a * b <= 1.0 + 1.0;
}