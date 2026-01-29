include "../definitions.dfy"
include "../library.dfy"

lemma imo_1973_p3(a: real, b: real)
  requires exists x :: x*x*x*x + a*x*x*x + b*x*x + a*x + 1.0 == 0.0
  ensures 4.0/5.0 <= a*a + b*b 
{}