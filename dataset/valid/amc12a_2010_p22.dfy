// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2010_p22(x: real)
  ensures 49.0 <= Real.sum(set k {:trigger (k as real)} | 1 <= k <= 119 :: k, k => Real.abs((k as real)*x - 1.0))
{}