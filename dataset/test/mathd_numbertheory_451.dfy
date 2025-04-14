// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_451(s: set<nat>)
  requires forall n: nat :: n in s <==> ((2010 <= n <= 2019) && (exists m :: (|divisors(m)| == 4 && (Int.sum(divisors(m), p => p) == n))))
  ensures Int.sum(s, k => k) == 2016
{}