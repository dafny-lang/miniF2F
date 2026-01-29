include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_175()
  ensures Int.pow(2, 2010) % 10 == 4
{}