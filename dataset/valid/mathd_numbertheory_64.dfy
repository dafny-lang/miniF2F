// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_64()
  ensures is_least(iset x: nat | (30*x)%47 == 42%47, 39)
{}