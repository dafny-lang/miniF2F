include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_320(n: nat)
  requires n < 101
  requires (123456 - n) % 101 == 0
  ensures n == 34
{}