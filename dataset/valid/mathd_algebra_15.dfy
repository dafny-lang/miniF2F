include "../utils.dfy"

import opened Utils

lemma mathd_algebra_15(s: nat -> nat -> nat)
  requires forall a, b | 0 < a && 0 < b :: s(a)(b) == pow(a, b) + pow(b, a)
  ensures s(2)(6) == 100
{}