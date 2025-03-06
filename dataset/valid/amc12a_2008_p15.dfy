// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12a_2008_p15(k: nat)
  requires k == Int.pow(2008, 2) + Int.pow(2, 2008)
  ensures (Int.pow(k, 2) + Int.pow(2, k)) % 10 == 6
{}