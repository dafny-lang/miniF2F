include "../utils.dfy"

import opened Utils

lemma mathd_algebra_10()
  ensures abs(120.0/100.0*30.0 - 130.0/100.0*20.0) == 10.0
{}