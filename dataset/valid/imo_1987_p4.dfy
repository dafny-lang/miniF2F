include "../utils.dfy"

lemma imo_1987_p4(f: nat -> nat) returns (n: nat)
  ensures f(f(n)) != n + 1987
{}