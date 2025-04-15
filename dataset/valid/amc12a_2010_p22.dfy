// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12a_2010_p22(x: real)
  ensures 49.0 <= Real.sum(set k | 1 <= k <= 119 :: k, k => abs((k as real)*x - 1.0))
{}