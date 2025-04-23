// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12a_2021_p19(s: set<real>)
  requires forall x: real :: x in s <==> ((0.0 <= x <= pi()) && ((sin(pi()/2.0*cos(x))) == cos(pi()/2.0*sin(x))))
  ensures |s| == 2
{}