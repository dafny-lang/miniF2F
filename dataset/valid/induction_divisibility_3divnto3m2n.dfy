include "../utils.dfy"

lemma induction_divisibility_3divnto3m2n(n: nat)
  ensures (n*n*n + 2*n) % 3 == 0
{}