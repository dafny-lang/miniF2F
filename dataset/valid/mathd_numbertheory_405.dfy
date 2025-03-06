// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_405(a: nat, b: nat, c: nat, t: nat -> nat)
  requires t(0) == 0
  requires t(1) == 1
  requires forall n | n > 1 :: t(n) == t(n-2) + t(n-1)
  requires a % 16 == 5
  requires b % 16 == 10
  requires b % 16 == 15
  ensures (t(a) + t(b) + t(c)) % 7 == 5
{}