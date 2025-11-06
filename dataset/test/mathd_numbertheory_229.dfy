// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_229()
  ensures Int.pow(5, 30) % 7 == 1
{}