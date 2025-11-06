// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_314(r: nat, n: nat)
  requires r == 1342 % 13
  requires 0 < n
  requires n % 1342 == 0
  requires n % 13 < r
  ensures 6710 <= n
{}