// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2020_p9(s: set<real>)
  requires forall x: real :: x in s <==> ((0.0 <= x <= 2.0*pi()) && tan(2.0*x) == cos(x/2.0))
  ensures |s| == 5
{}