// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_728()
  ensures (Int.pow(29, 13) - Int.pow(5, 13)) % 7 == 0
{}