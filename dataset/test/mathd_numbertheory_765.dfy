// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_765(x: int)
  requires x < 0
  requires (24*x) % 1199 == 15
  ensures x <= -449
{}