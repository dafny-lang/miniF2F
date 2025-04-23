// Author: Stefan Zetzsche

include "../utils.dfy"

lemma aime_1997_p12(x: real)
  requires Real.sum(set k | 1 <= k <= 44 :: k, k => sin((k as real)*pi()/180.0)) != 0.0
  requires x == Real.sum(set k | 1 <= k <= 44 :: k, k => cos((k as real)*pi()/180.0)) / Real.sum(set k | 1 <= k <= 44 :: k, k => sin((k as real)*pi()/180.0))
  ensures floor(100.0*x) == 241
{}