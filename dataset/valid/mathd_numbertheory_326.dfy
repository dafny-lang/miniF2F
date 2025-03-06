// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_326(n: nat)
  requires (n - 1) * n * (n + 1) == 720
  ensures n + 1 == 10
{}