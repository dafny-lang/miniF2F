include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_136(n: nat)
  requires 123*n + 17 == 39500
  ensures n == 321
{}