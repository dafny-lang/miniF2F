include "../utils.dfy"

lemma induction_divisibility_3div2tooddnp1(n: nat)
  ensures (Int.pow(2, 2*n+1) + 1) % 3 == 0
{}