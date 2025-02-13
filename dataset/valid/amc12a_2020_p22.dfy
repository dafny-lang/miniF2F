include "../utils.dfy"

// added n > 0
lemma amc12a_2020_p22(S: set<nat>)
  requires forall n: nat :: n in S <==> n > 0 && (n % 5 == 0) && lcm(factorial(5), n) == 5*gcd(factorial(10), n)
  ensures |S| == 1
{}