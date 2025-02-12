include "../utils.dfy"

import opened Utils

lemma induction_pprime_pdvdapowpma(p: nat, a: nat)
  requires 0 < a
  requires prime(p)
  ensures (pow(a, p) - a) % p == 0
{}