include "../utils.dfy"

import opened Utils

// added n > 0
lemma amc12a_2020_p22(S: set<nat>)
  requires forall n: nat :: n in S <==> n > 0 && (n % 5 == 0) && lcm(factorial(5), n) == 5*gcd(factorial(10), n)
  ensures |S| == 1
lemma amc12a_2020_p22(S: set<nat>)
  requires forall n: nat :: n in S <==> n > 0 && (n % 5 == 0) && lcm(factorial(5), n) == 5*gcd(factorial(10), n)
  ensures |S| == 1
{
  var n := 5;
  assert n in S;
  assert n > 0;
  assert n % 5 == 0;
  assert lcm(factorial(5), n) == 5*gcd(factorial(10), n);
  assert factorial(5) == 120;
  assert factorial(10) == 3628800;
  assert gcd(factorial(10), n) == 5;
  assert lcm(factorial(5), n) == 5 * 5;
  assert 5 * 5 == 5 * gcd(factorial(10), n);
  var m := 10;
  assert m % 5 == 0;
  assert m > 0;
  assert lcm(factorial(5), m) != 5*gcd(factorial(10), m);
  assert m !in S;
  assert S == {n};
  assert |S| == 1;
}