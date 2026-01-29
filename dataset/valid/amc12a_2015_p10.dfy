include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2015_p10(x: int, y: int)
  requires 0 < y
  requires y < x
  requires x + y + (x * y) == 80
  ensures x == 26
{}