// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_543()
  ensures Int.sum(divisors(Int.pow(30, 4)), k => 1) - 2 == 123
{}