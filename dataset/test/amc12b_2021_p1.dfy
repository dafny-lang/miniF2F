// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12b_2021_p1(s: set<int>)
  requires forall x: int :: x in s <==> abs(x as real) < 3.0*pi
  ensures |s| == 19
{}