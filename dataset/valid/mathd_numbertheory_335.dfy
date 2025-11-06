// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_335(n: nat)
  requires n % 7 == 5
  ensures 5*n % 7 == 4
{}