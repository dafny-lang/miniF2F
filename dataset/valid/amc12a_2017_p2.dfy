// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2017_p2(x: real, y: real)
  requires x != 0.0
  requires y != 0.0
  requires x + y == 4.0 * (x * y)
  ensures 1.0 / x + 1.0 / y == 4.0
{}