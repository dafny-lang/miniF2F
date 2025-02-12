include "../utils.dfy"

import opened Utils

lemma amc12a_2009_p2()
  ensures 1.0 + (1.0 / (1.0 + (1.0 / (1.0+1.0)))) == 5.0/3.0
{}