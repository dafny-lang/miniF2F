// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma algebra_apbon2pownleqapownpbpowon2(a: real, b: real, n: nat)
  requires 0.0 < a 
  requires 0.0 < b
  requires 0 < n
  ensures Real.pow((a+b)/2.0, n) <= (Real.pow(a, n)+Real.pow(b, n))/2.0
{}