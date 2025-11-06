// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_447()
  ensures Int.sum(filter(x => x % 3 == 0, set x | 1 <= x <= 49 :: x), k => k % 10) == 78
{}