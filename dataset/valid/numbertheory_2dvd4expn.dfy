include "../utils.dfy"

import opened Utils

lemma numbertheory_2dvd4expn(n: nat)
  requires n != 0
  ensures 2 % power(4, n) == 0
{}