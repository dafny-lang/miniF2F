// Author: Stefan Zetzsche

include "../utils.dfy"

lemma imo_1997_p5(x: nat, y: nat)
  requires 0 < x
  requires 0 < y
  requires Int.pow(x, Int.pow(y, 2)) == Int.pow(y, x)
  ensures (x, y) == (1, 1) || (x, y) == (16, 2) || (x, y) == (27, 3)
{}