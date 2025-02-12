include "../utils.dfy"

import opened Utils

lemma imo_1990_p3(n: nat)
  requires 2 <= n
  requires power(n, 2) % power(2, n) + 1 == 0
  ensures n == 3
{}