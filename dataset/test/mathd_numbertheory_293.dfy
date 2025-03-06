// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_293(n: nat)
  requires n <= 9
  requires (20*100 + 10*n + 7) % 11 == 0
  ensures n == 5
{}