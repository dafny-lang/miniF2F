// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12b_2003_p17(x: real, y: real)
  requires 0.0 < x
  requires 0.0 < y
  requires log(x*y*y*y) == 1.0
  requires log(x*x*y) == 1.0
  ensures log(x*y) == 3.0/5.0
{}