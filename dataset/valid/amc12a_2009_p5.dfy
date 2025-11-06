// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2009_p5(x: real)
  requires x*x*x - (x+1.0)*(x-1.0)*x == 5.0
  ensures x*x*x == 125.0
{}