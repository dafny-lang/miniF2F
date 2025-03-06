// Author: Stefan Zetzsche

include "../utils.dfy"

lemma algebra_abpbcpcageq3_sumaonsqrtapbgeq3onsqrt2(a: real, b: real, c: real)
  requires 0.0 < a 
  requires 0.0 < b
  requires 0.0 < c
  requires 3.0 <= a*b + b*c + c*a
  ensures 3.0/sqrt(2.0) <= a/sqrt(a+b) + b/sqrt(b+c) + c/sqrt(c+a)
{}