// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_769()
  ensures (Int.pow(129, 34) + Int.pow(96, 38)) % 11 == 9
{}