include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_234(a: nat, b: nat)
  requires 1 <= a <= 9
  requires b <= 9
  requires pow(10*a + b, 3) == 912673
  ensures a + b == 16
{}