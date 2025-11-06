// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma imo_1959_p1(n: nat)
  requires 0 < n
  ensures gcd(21*n + 4, 14*n + 3) == 1
{}