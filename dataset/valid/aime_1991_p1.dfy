// Author: Stefan Zetzsche

include "../utils.dfy"

lemma aime_1991_p1(x: nat, y: nat)
  requires 0 < x 
  requires 0 < y
  requires x*y + (x+y) == 71
  requires x*x*y + x*y*y == 880
  ensures x*x + y*y == 146
{}