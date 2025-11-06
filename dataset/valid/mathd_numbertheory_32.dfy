// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_32(s: set<nat>)
  requires forall n :: n in s <==> n % 36 == 0
  ensures Int.sum(s, k => k) == 91
{}