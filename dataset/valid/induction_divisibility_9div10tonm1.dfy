include "../utils.dfy"

import opened Utils

lemma induction_divisibility_9div10tonm1(n: nat)
  requires 0 < n
  ensures 9 % (power(10, n) - 1) == 0
{}