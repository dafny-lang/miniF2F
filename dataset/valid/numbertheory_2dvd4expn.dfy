include "../utils.dfy"

lemma numbertheory_2dvd4expn(n: nat)
  requires n != 0
  ensures 2 % Int.pow(4, n) == 0
{}