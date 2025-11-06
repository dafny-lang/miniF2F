// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_127()
  ensures Int.sum(range(101), k => Int.pow(2, k)) % 7 == 3
{}