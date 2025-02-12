include "../utils.dfy"

import opened Utils

lemma amc12b_2002_p11(a: nat, b: nat)
  requires prime(a)
  requires prime(b)
  requires prime(a+b)
  requires prime(a-b)
  ensures prime(a + b + a - b + a + b)
lemma amc12b_2002_p11(a: nat, b: nat)
  requires prime(a)
  requires prime(b)
  requires prime(a+b)
  requires prime(a-b)
  ensures prime(a + b + a - b + a + b)
{
  assert a + b + a - b + a + b == 3 * a + 2 * b;
  assert 3 * a + 2 * b == a + (2 * a + 2 * b);
  assert 2 * a + 2 * b == 2 * (a + b);
  assert prime(a + b);
  assert 2 * (a + b) % 2 == 0;
  assert a + 2 * (a + b) % 2 != 0;
  assert a + 2 * (a + b) != 2;
  assert a + 2 * (a + b) > 2;
  assert !prime(a + 2 * (a + b));
  assert !prime(3 * a + 2 * b);
}