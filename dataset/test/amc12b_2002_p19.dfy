include "../definitions.dfy"
include "../library.dfy"

lemma amc12b_2002_p19(a: real, b: real, c: real)
  requires 0.0 < a
  requires 0.0 < b
  requires 0.0 < c
  requires a * (b+c) == 152.0
  requires b + (c+a) == 162.0
  requires c + (a+b) == 170.0
  ensures a*b*c == 720.0
{}