include "../utils.dfy"

lemma amc12a_2021_p8(d: nat -> nat)
  requires d(0) == 0
  requires d(1) == 0
  requires d(2) == 1
  requires forall n | n >= 3 :: d(n) == d(n-1) + d(n-3)
  ensures d(2021) % 2 == 0
  ensures d(2022) % 2 == 1
  ensures d(2023) % 2 == 0
{}