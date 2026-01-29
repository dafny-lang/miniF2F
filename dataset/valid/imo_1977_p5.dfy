include "../definitions.dfy"
include "../library.dfy"

lemma imo_1977_p5(a: nat, b: nat, q: nat, r: nat)
  requires r < a + b
  requires a*a + b*b == (a+b)*q + r
  requires q*q + r == 1977
  ensures (a - 22 == 15 && b - 22 == 28) || (a - 22 == 28 && b - 22 == 15)
{}