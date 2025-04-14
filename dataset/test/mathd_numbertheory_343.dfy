// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_343()
  ensures Int.prod(range(6), k => (2*k+1)) % 10 == 5
{}