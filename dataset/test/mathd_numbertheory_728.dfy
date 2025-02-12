include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_728()
  ensures (pow(29, 13) - pow(5, 13)) % 7 == 0
{}