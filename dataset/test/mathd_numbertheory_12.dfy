include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_12()
  ensures |filter(x => x % 20 == 0, set x | 15 <= x <= 85 :: x)| == 4
{}