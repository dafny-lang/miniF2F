include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_296(n: nat)
  requires 2 <= n
  requires exists x :: power(x, 3) == n
  requires exists t :: power(t, 4) == n
  ensures 4096 <= n
{}