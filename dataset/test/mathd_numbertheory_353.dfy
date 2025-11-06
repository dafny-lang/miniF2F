// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_353(s: nat)
  requires s == Int.sum(set x | 2010 <= x <= 4018 :: x, k => k)
  ensures s % 2009 == 0
{}