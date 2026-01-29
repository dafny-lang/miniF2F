include "../definitions.dfy"
include "../library.dfy"

lemma amc12b_2004_p3(x: nat, y: nat)
  requires Int.pow(2, x) * Int.pow(3, y) == 1296
  ensures x + y == 8
{}