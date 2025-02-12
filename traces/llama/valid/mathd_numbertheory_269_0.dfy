include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_269()
  ensures (pow(2005, 2) + pow(2005, 0) + pow(2005, 0) + pow(2005, 5)) % 100 == 52
{}