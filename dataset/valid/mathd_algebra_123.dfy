include "../utils.dfy"

import opened Utils

lemma mathd_algebra_123(a: nat, b: nat)
  requires 0 < a
  requires 0 < b
  requires a + b == 20
  requires a == 3 * b
  ensures a - b == 10
{}