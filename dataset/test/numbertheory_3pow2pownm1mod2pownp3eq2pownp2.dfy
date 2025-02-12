include "../utils.dfy"

import opened Utils

lemma numbertheory_3pow2pownm1mod2pownp3eq2pownp2(n: nat)
  requires 0 < n
  ensures (pow(3, pow(2, n)) - 1) % (pow(2, n+3)) == pow(2, n+2)
{}