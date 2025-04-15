// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_155()
  ensures |filter(x => x % 19 == 7, set x | 100 <= x <= 999)| == 52
{}