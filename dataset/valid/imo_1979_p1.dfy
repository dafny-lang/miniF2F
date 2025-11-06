// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma imo_1979_p1(p: nat, q: nat)
  requires 0 < q
  requires Real.sum(set k | 1 <= k <= 1319 :: k, k => if k <= 0 then 0.0 else Real.pow(-1.0, k+1) * 1.0/(k as real)) == (p as real)/(q as real)
  ensures p % 1979 == 0
{}