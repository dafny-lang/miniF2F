// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12_2001_p21(a: nat, b: nat, c: nat, d: nat)
  requires a*b*c*d == factorial(8)
  requires a*b + a + b == 524
  requires b*c + b + c == 146
  requires c*d + c + d == 104
  ensures a - d == 10
{}