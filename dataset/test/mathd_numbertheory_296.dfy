// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_296(n: nat)
  requires 2 <= n
  requires exists x :: Int.power(x, 3) == n
  requires exists t :: Int.power(t, 4) == n
  ensures 4096 <= n
{}