include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_198()
  ensures Int.pow(5, 2005) % 100 == 25
{}