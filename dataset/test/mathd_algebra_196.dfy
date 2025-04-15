// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_196(s: set<real>)
  requires forall x: real :: x in s <==> (abs(2.0-x) == 3.0)
  ensures Real.sum(s, k => k) == 4.0
{}