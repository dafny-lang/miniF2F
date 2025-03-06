// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_458(n: nat)
  requires n % 8 == 7
  ensures n % 4 == 3
{}