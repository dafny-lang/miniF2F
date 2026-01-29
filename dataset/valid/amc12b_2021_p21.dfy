include "../definitions.dfy"
include "../library.dfy"

lemma amc12b_2021_p21(s: set<real>)
  requires forall x :: x in s <==> (0.0 < x && Real.rpow(x, Real.rpow(2.0, sqrt(2.0))) == Real.rpow(sqrt(2.0), Real.rpow(2.0, x)))
  ensures 2.0 <= Real.sum(s, k => k) < 6.0
{}