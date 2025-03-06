// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12a_2008_p8(x: real, y: real)
  requires 0.0 < x
  requires 0.0 < y
  requires y*y*y == 1.0
  requires 6.0*x*x == 2.0*(6.0*y*y)
  ensures x*x*x == 2.0*sqrt(2.0)
{}