include "../utils.dfy"

lemma amc12b_2021_p4(m: nat, a: nat)
  requires 0 < m 
  requires 0 < a
  requires (m as real)/(a as real) == (3 as real)/4.0
  ensures (84.0*(m as real) + 70.0*(a as real)) / ((m as real)+(a as real)) == 76.0
{}