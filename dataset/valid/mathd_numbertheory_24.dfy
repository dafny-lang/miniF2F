// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_24()
  ensures Int.sum(set k | 1 <= k <= 9 :: k, k => Int.pow(11, k)) % 100 == 59
{}