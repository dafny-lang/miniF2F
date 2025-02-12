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
  var lhs := 24.0*x*x - 19.0*x - 35.0;
  var rhs := (a*x - 5.0) * (2.0*b*x + c);
  assert lhs == rhs;
  var lhsCoeffX2 := 24.0;
  var rhsCoeffX2 := 2.0*a*b;
  assert lhsCoeffX2 == rhsCoeffX2;
  var lhsCoeffX := -19.0;
  var rhsCoeffX := a*c + 2.0*b*(-5.0);
  assert lhsCoeffX == rhsCoeffX;
  var lhsCoeff1 := -35.0;
  var rhsCoeff1 := -5.0*c;
  assert lhsCoeff1 == rhsCoeff1;
  assert a*b == 12.0;
  assert a*c - 10.0*b == -19.0;
  assert -5.0*c == -35.0;
  assert c == 7.0;
  assert a*b - 3.0*c == 12.0 - 3.0*7.0;
  assert a*b - 3.0*c == 12.0 - 21.0;
  assert a*b - 3.0*c == -9.0;
}