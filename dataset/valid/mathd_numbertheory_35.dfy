// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_35(s: set<nat>)
  requires forall n, m | (m*m == 196) :: (m % n == 0)
  ensures Int.sum(s, k => k) == 24
{}