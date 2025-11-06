// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_284(a: nat, b: nat)
  requires 1 <= a <= 9
  requires b <= 9
  requires 10*a + b == 2*(a+b)
  ensures 10*a +b == 18
{}