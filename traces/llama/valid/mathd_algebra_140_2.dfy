include "../utils.dfy"

import opened Utils

lemma mathd_algebra_140(a: real, b: real, c: real)
  requires 0.0 < a
  requires 0.0 < b
  requires 0.0 < c
  requires forall x :: 24.0*x*x - 19.0*x - 35.0 == (a*x - 5.0) * (2.0*b*x + c)
  ensures a*b - 3.0*c == -9.0
{
  var x := 0.0;
  var x1 := 1.0;
  var x2 := 2.0;
  assert 24.0*x*x - 19.0*x - 35.0 == (a*x - 5.0) * (2.0*b*x + c);
  assert 24.0*x1*x1 - 19.0*x1 - 35.0 == (a*x1 - 5.0) * (2.0*b*x1 + c);
  assert 24.0*x2*x2 - 19.0*x2 - 35.0 == (a*x2 - 5.0) * (2.0*b*x2 + c);
  assert -35.0 == (a*0.0 - 5.0) * (2.0*b*0.0 + c);
  assert -35.0 == -5.0 * c;
  assert c == 7.0;
  assert 5.0 == (a*1.0 - 5.0) * (2.0*b*1.0 + 7.0);
  assert 5.0 == (a - 5.0) * (2.0*b + 7.0);
  assert 5.0 == a*(2.0*b + 7.0) - 5.0*(2.0*b + 7.0);
  assert 5.0 + 5.0*(2.0*b + 7.0) == a*(2.0*b + 7.0);
  assert 5.0 + 10.0*b + 35.0 == a*(2.0*b + 7.0);
  assert 40.0 + 10.0*b == a*(2.0*b + 7.0);
  assert 95.0 == (a*2.0 - 5.0) * (2.0*b*2.0 + 7.0);
  assert 95.0 == (2.0*a - 5.0) * (4.0*b + 7.0);
  assert 95.0 == 2.0*a*(4.0*b + 7.0) - 5.0*(4.0*b + 7.0);
  assert 95.0 == 8.0*a*b + 14.0*a - 20.0*b - 35.0;
  assert 130.0 + 20.0*b == 8.0*a*b + 14.0*a;
  assert 130.0 + 10.0*b == 4.0*a*b + 7.0*a;
  assert 130.0 + 10.0*b == a*(4.0*b + 7.0);
  assert 40.0 + 10.0*b == a*(2.0*b + 7.0);
  assert 130.0 + 10.0*b == 2.0*(40.0 + 10.0*b);
  assert 130.0 + 10.0*b == 80.0 + 20.0*b;
  assert 50.0 == 10.0*b;
  assert 5.0 == b;
  assert 40.0 + 10.0*b == a*(2.0*b + 7.0);
  assert 40.0 + 10.0*5.0 == a*(2.0*5.0 + 7.0);
  assert 40.0 + 50.0 == a*(10.0 + 7.0);
  assert 90.0 == 17.0*a;
  assert a == 90.0 / 17.0;
  assert a == 5.2941176470588235;
  assert a*b - 3.0*c == (90.0 / 17.0)*5.0 - 3.0*7.0;
  assert a*b - 3.0*c == 450.0 / 17.0 - 21.0;
  assert a*b - 3.0*c == (450.0 - 357.0) / 17.0;
  assert a*b - 3.0*c == 93.0 / 17.0;
  assert a*b - 3.0*c == -9.0;
}