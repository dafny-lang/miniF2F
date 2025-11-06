// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma imo_2006_p6(a: real, b: real, c: real)
  ensures (a*b*(a*a-b*b)) + (b*c*(b*b-c*c)) + (c*a*(c*c-a*a)) <= 9.0*sqrt(2.0)/32.0 * Real.pow(a*a + b*b + c*c, 2)
{}