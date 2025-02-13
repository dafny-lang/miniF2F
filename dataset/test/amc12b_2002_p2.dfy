include "../utils.dfy"

lemma amc12b_2002_p2(x: int)
  requires x == 4
  ensures (3*x-2)*(4*x+1) - (3*x-2)*(4*x) + 1 == 11
{}