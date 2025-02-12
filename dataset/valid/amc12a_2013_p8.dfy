include "../utils.dfy"

import opened Utils

lemma amc12a_2013_p8(x: real, y: real)
  requires x != 0.0
  requires y != 0.0
  requires x != y
  requires x + 2.0/x == y + 2.0/y
  ensures x * y == 2.0
{}