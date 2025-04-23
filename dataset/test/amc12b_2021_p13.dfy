// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12b_2021_p13(s: set<real>)
  requires forall x: real :: (x in s <==> ((0.0 < x <= 2.0*pi()) && (1.0 - 3.0*sin(x) + 5.0*cos(3.0*x) == 0.0)))
  ensures |s| == 6
{}