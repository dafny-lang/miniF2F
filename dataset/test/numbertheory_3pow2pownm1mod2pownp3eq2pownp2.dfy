include "../utils.dfy"

lemma numbertheory_3pow2pownm1mod2pownp3eq2pownp2(n: nat)
  requires 0 < n
  ensures (Int.pow(3, Int.pow(2, n)) - 1) % (Int.pow(2, n+3)) == Int.pow(2, n+2)
{}