// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_215(s: set<real>)
  requires forall x :: x in s <==> (x+3.0)*(x+3.0) == 121.0
  ensures Real.sum(s, k => k) == -6.0
{}