include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_239()
  ensures Int.sum(set x | 1 <= x <= 12 :: x, k => k) % 4 == 2
{}