// Author: Stefan Zetzsche

include "../utils.dfy"

lemma imo_1964_p1_2(n: nat)
  ensures (Int.pow(2,n) + 1) % 7 != 0
{}