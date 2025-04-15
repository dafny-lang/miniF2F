// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_466()
  ensures Int.sum(range(11), k => k) % 9 == 1
{}