// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12_2000_p12(a: nat, m: nat, c: nat)
  requires a + m + c == 12
  ensures a*m*c + a*m + m*c + a*c <= 112
{}