// Author: Stefan Zetzsche

include "../utils.dfy"

lemma aime_1991_p6(r: real)
  requires Int.sum(set k: int | 19 <= k <= 91 :: k, (k: int) => floor(r + (k as real)/100.0)) == 546
  ensures floor(100.0*r) == 743
{}