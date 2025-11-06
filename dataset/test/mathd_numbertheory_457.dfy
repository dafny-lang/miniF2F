// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_457(n: nat)
  requires 0 < n
  requires factorial(n) % 80325 == 0
  ensures 17 <= n
{}