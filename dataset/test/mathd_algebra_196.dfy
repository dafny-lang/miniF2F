include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_196(s: set<real>)
  requires forall x: real :: x in s <==> (Real.abs(2.0-x) == 3.0)
  ensures Real.sum(s, k => k) == 4.0
{}