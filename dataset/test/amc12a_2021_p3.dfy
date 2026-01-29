include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2021_p3(x: nat, y: nat)
  requires x + y == 17402
  requires x % 10 == 0
  requires x / 10 == y
  ensures x - y == 14238
{}