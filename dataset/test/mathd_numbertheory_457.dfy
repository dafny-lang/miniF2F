include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_457(n: nat)
  requires 0 < n
  requires factorial(n) % 80325 == 0
  ensures 17 <= n
{}