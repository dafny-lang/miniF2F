include "../utils.dfy"

lemma induction_pprime_pdvdapowpma(p: nat, a: nat)
  requires 0 < a
  requires prime(p)
  ensures (Int.pow(a, p) - a) % p == 0
{}