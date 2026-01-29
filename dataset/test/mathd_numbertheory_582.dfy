include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_582(n: nat)
  requires 0 < n
  requires n % 3 == 0
  ensures ((n + 4) + (n + 6) + (n + 8)) % 9 == 0
{}