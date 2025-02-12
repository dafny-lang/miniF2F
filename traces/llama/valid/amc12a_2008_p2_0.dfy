include "../utils.dfy"

import opened Utils

lemma amc12a_2008_p2(x: real)
  requires x * (1.0/2.0 + 2.0/3.0) == 1.0
  ensures x == 6.0/7.0
{}