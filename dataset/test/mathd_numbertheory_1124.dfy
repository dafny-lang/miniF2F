include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_1124(n: nat)
  requires n <= 9
  requires 18 % (374 * 10 + n) == 0
  ensures n == 4
{}