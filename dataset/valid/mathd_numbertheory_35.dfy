include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_35(s: set<nat>)
  requires forall n : nat :: n in s <==> n != 0 && exists m : nat :: m * m == 196 && m % n == 0
  ensures Int.sum(s, k => k) == 24
{}