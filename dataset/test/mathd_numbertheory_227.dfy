include "../utils.dfy"

lemma mathd_numbertheory_227(x: nat, y: nat, n: nat)
  requires x > 0
  requires y > 0
  requires n > 0 
  requires x/4 + y/6 == (x+y)/n
  ensures n == 5
{}