// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma imo_1965_p1(x: real)
  requires 0.0 <= x
  requires x <= 2.0*pi()
  requires 2.0 * cos(x) <= Real.abs(sqrt(1.0 + sin(2.0*x)) - sqrt(1.0 - sin(2.0*x)))
  requires Real.abs(sqrt(1.0 + sin(2.0*x)) - sqrt(1.0 - sin(2.0*x))) <= sqrt(2.0)
  ensures pi()/4.0 <= x <= 7.0*pi()/4.0
{}