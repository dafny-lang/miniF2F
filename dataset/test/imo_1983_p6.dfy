include "../definitions.dfy"
include "../library.dfy"

lemma imo_1983_p6(a: real, b: real, c: real)
  requires 0.0 < a 
  requires 0.0 < b 
  requires 0.0 < c
  requires c < a + b
  requires b < a + c
  requires a < b + c
  ensures 0.0 <= a*a * b * (a - b) + b*b * c * (b - c) + c*c * a * (c - a)
{}