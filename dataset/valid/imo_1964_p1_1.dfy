include "../utils.dfy"

import opened Utils

lemma imo_1964_p1_1(n: nat)
  requires n != 0 // added this manually
  requires 7 % (power(2, n) - 1) == 0
  ensures 3 % n == 0
{}