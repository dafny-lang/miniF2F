include "../utils.dfy"

import opened Utils

lemma aime_1997_p9(a: real)
  requires 0.0 < a
  requires (1.0/a) - (1.0/a).Floor as real == a*a - (a*a).Floor as real
  requires 2.0 < a*a
  requires a*a < 3.0
  ensures pow(a, 12) as real - 144.0 * (1/a) == 233.0