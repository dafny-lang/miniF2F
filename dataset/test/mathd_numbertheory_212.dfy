include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_212()
  ensures (pow(16, 17) * pow(17, 18) * pow(18, 19)) % 10 == 8
{}