// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma imo_1965_p2(x: real, y: real, z: real, a: nat -> real)
  requires 0.0 < a(0) 
  requires 0.0 < a(4) 
  requires 0.0 < a(8)
  requires a(1) < 0.0
  requires a(2) < 0.0
  requires a(3) < 0.0 
  requires a(5) < 0.0
  requires a(7) < 0.0
  requires a(9) < 0.0
  requires 0.0 < a(0) + a(1) + a(2)
  requires 0.0 < a(3) + a(4) + a(5)
  requires 0.0 < a(6) + a(7) + a(8)
  requires a(0) * x + a(1) * y + a(2) * z == 0.0
  requires a(3) * x + a(4) * y + a(5) * z == 0.0
  requires a(6) * x + a(7) * y + a(8) * z == 0.0
  ensures x == 0.0
  ensures y == 0.0
  ensures z == 0.0
{}