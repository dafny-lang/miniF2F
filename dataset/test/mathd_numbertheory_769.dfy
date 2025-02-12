include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_769()
  ensures (pow(129, 34) + pow(96, 38)) % 11 == 9
{}