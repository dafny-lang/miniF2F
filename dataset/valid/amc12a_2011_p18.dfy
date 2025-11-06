// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2011_p18(x: real, y: real)
  requires Real.abs(x + y) + Real.abs(x - y) == 2.0
  ensures x*x - 6.0*x + y*y <= 9.0
{}