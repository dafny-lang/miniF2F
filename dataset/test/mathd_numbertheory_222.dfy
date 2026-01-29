include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_222(b: nat)
  requires b > 0 // added
  requires lcm(120, b) == 3720
  requires gcd(120, b) == 8
  ensures b == 248
{}