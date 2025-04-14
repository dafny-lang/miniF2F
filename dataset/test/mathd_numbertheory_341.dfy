// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_341(a: nat, b: nat, c: nat)
  requires a <= 9
  requires b <= 9
  requires c <= 9
  requires digits(10, Int.pow(5,100) % 1000) == [c,b,a]
  ensures a+b+c == 13
{}