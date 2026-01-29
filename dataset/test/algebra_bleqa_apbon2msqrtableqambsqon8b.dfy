include "../definitions.dfy"
include "../library.dfy"

lemma algebra_bleqa_apbon2msqrtableqambsqon8b(a: real, b: real)
  requires 0.0 < a
  requires 0.0 < b 
  requires b <= a
  ensures (a+b)/2.0 - sqrt(a*b) <= ((a-b)*(a-b)) / (8.0*b)
{}