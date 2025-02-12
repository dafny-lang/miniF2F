include "../utils.dfy"

import opened Utils

// added n > 0
lemma amc12a_2020_p22(S: set<nat>)
  requires forall n: nat :: n in S <==> n > 0 && (n % 5 == 0) && lcm(factorial(5), n) == 5*gcd(factorial(10), n)
  ensures |S| == 1
{
  assert lcm(factorial(5), 5) == 5*gcd(factorial(10), 5);
  assert forall n: nat :: n > 0 && n % 5 == 0 && lcm(factorial(5), n) == 5*gcd(factorial(10), n) <==> n == 5;
  assert S == {5};
}