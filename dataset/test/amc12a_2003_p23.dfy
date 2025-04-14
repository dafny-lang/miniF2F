// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12a_2003_p23(s: set<nat>)
  requires forall k: nat :: k in s <==> (0 < k && (Int.prod(set i | 1 <= i <= 9 :: i, i => factorial(i)) % (k*k) == 0))
  ensures |s| == 672
{}