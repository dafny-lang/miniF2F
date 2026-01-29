include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_296(n: nat)
  requires 2 <= n
  requires exists x :: Int.pow(x, 3) == n
  requires exists t :: Int.pow(t, 4) == n
  ensures 4096 <= n
{}