include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2019_p12(x: real, y: real)
  requires x != 1.0
  requires y != 1.0
  requires log(y) != 0.0
  requires log(x)/log(2.0) == log(16.0)/log(y)
  requires x*y == 64.0
  ensures log(x/y)/log(2.0) == 20.0
{}