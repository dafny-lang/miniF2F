// Author: Stefan Zetzsche

include "../utils.dfy"

lemma induction_pord1p1on2powklt5on2(n: nat)
  requires 0 < n
  ensures Real.prod(set k: int | 1 <= k <= n, (k: int) => if k < 1 then 1.0 else 1.0 + 1.0/Real.pow(2.0,k)) < 5.0/2.0
{}