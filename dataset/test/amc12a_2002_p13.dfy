// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2002_p13(a: real, b: real)
  requires 0.0 < a 
  requires 0.0 < b
  requires a != b
  requires Real.abs(a - 1.0/a) == 1.0
  requires Real.abs(b - 1.0/b) == 1.0
  ensures a+b == sqrt(5.0)
{}