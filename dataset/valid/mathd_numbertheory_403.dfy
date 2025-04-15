// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_403()
  ensures Int.sum(divisors(198), k => k) == 270
{}