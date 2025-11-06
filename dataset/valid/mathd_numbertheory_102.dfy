// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_102()
  ensures Int.pow(2, 8) % 5 == 1
{}