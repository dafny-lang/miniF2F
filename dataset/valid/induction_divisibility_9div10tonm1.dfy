// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma induction_divisibility_9div10tonm1(n: nat)
  requires 0 < n
  ensures (Int.pow(10, n) - 1) % 9 == 0
{}