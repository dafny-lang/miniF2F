include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_202()
  ensures power(19, 19) + power(99, 99) % 10 == 8
{}