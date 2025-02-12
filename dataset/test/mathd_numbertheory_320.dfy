include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_320(n: nat)
  requires n < 101
  requires (123456 - n) % 101 == 0
  ensures n == 34
{}