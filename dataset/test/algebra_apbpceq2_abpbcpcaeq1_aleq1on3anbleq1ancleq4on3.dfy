include "../definitions.dfy"
include "../library.dfy"

lemma algebra_apbpceq2_abpbcpcaeq1_aleq1on3anbleq1ancleq4on3(a: real, b: real, c: real)
  requires a <= b <= c
  requires a + b + c == 2.0
  requires a*b + b*c + c*a == 1.0
  ensures 0.0 <= a <= 1.0/3.0
  ensures 1.0/3.0 <= b <= 1.0
  ensures 1.0 <= c <= 4.0/3.0
{}