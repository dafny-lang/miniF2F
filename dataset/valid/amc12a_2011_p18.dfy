include "../utils.dfy"

lemma amc12a_2011_p18(x: real, y: real)
  requires abs(x + y) + abs(x - y) == 2.0
  ensures x*x - 6.0*x + y*y <= 9.0
{}