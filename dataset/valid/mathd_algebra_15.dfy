// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_15(s: nat -> nat -> nat)
  requires forall a, b | 0 < a && 0 < b :: s(a)(b) == Int.pow(a, b) + Int.pow(b, a)
  ensures s(2)(6) == 100
{}