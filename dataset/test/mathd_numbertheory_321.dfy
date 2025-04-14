// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_321(n: nat)
  requires 0 <= n < 1399
  requires (n * 160) % 1399 == 1
  ensures n == 1058
{}