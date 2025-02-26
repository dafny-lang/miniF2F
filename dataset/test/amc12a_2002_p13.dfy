include "../utils.dfy"

lemma amc12a_2002_p13(a: real, b: real)
  requires 0.0 < a 
  requires 0.0 < b
  requires a != b
  requires abs(a - 1.0/a) == 1.0
  requires abs(b - 1.0/b) == 1.0
  ensures a+b == sqrt(5.0)
{}