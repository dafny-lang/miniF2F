// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_150(n: nat)
  requires !(prime(7 + 30*n))
  ensures 6 <= n
{}