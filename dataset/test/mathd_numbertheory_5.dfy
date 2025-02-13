include "../utils.dfy"

lemma mathd_numbertheory_5(n: nat)
  requires 10 <= n
  requires exists x :: x*x == n
  requires exists t :: t*t*t == n
  ensures 64 <= n
{}