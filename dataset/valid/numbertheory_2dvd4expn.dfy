include "../definitions.dfy"
include "../library.dfy"

lemma numbertheory_2dvd4expn(n: nat)
  requires n != 0
  ensures Int.pow(4, n) % 2 == 0
{}