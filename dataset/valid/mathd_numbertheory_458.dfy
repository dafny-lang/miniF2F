// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_458(n: nat)
  requires n % 8 == 7
  ensures n % 4 == 3
{}