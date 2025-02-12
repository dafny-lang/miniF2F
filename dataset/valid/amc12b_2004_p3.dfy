include "../utils.dfy"

import opened Utils

lemma amc12b_2004_p3(x: nat, y: nat)
  requires pow(2, x) * pow(3, y) == 1296
  ensures x + y == 8
{}