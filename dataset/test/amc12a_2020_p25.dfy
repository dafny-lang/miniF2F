// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12a_2020_p25(a: rat, s: set<real>)
  requires forall x: real :: x in s <==> ((floor(x) as real)*(x - (floor(x) as real)) == a.to_real()*x*x)
  requires Real.sum(s, x => x) == 420.0
  ensures a.denom + a.num == 929
{}