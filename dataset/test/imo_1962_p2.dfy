include "../definitions.dfy"
include "../library.dfy"

lemma imo_1962_p2(x: real)
  requires 1.0/2.0 < sqrt(3.0-x) - sqrt(x+1.0)
  ensures -1.0 <= x < 1.0 - sqrt(31.0/8.0)
{}