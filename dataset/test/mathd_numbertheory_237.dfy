// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_237()
  ensures Int.sum(range(101), (k: int) => k) % 6 == 4
{}