include "../utils.dfy"

import opened Utils

lemma imo_1984_p2(a: nat, b: nat)
  requires 0 < a
  requires 0 < b
  requires 7 % a != 0
  requires 7 % b != 0
  requires 7 % (a+b) != 0
  requires pow(7, 7) % (pow(a + b, 7) - pow(a, 7) - pow(b, 7)) == 0
  ensures 19 <= a + b
{}