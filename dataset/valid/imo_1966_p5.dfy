// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma imo_1966_p5(x: nat -> real, a: nat -> real)
  requires a(1) != a(2)
  requires a(1) != a(3)
  requires a(1) != a(4)
  requires a(2) != a(3)
  requires a(2) != a(4)
  requires a(3) != a(4)
  requires Real.abs(a(1) - a(2)) * x(2) + Real.abs(a(1) - a(3)) * x(3) + Real.abs(a(1) - a(4)) * x(4) == 1.0
  requires Real.abs(a(2) - a(1)) * x(1) + Real.abs(a(2) - a(3)) * x(3) + Real.abs(a(2) - a(4)) * x(4) == 1.0
  requires Real.abs(a(3) - a(1)) * x(1) + Real.abs(a(3) - a(2)) * x(2) + Real.abs(a(3) - a(4)) * x(4) == 1.0
  requires Real.abs(a(4) - a(1)) * x(1) + Real.abs(a(4) - a(2)) * x(2) + Real.abs(a(4) - a(3)) * x(3) == 1.0
  ensures x(2) == 0.0
  ensures x(3) == 0.0
  ensures x(1) == 1.0/Real.abs(a(1) - a(4))
  ensures x(4) == 1.0/Real.abs(a(1) - a(4))
{}