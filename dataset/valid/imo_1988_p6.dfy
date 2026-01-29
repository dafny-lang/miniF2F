include "../definitions.dfy"
include "../library.dfy"

lemma imo_1988_p6(a: nat, b: nat)
  requires 0 < a
  requires 0 < b
  requires (a*a + b*b) % (a*b + 1) == 0
  ensures exists x: nat :: x*x == (a*a + b*b) / (a*b + 1)
{}