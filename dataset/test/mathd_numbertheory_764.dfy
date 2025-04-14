// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_764(p: nat, k_mod_p_inv: nat)
  requires prime(p)
  requires 7 <= p
  ensures Real.sum(set k: int | 1 <= k <= p-2, (k: int) => if k % p == 0 then 0.0 else 1.0/((k % p) as real) * 1.0/((k % p) as real + 1.0)) == 2.0
{}