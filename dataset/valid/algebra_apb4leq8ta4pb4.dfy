// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma algebra_apb4leq8ta4pb4(a: real, b: real)
  requires 0.0 < a
  requires 0.0 < b
  ensures Real.pow(a+b, 4) <= 8.0*(Real.pow(a, 4) + Real.pow(b, 4))
{}