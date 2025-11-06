// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_461(n: nat)
  requires n == |filter(x => gcd(x, 8) == 1, set k | 1 <= k <= 7 :: k)|
  ensures Int.pow(3, n) % 8 == 1
{}