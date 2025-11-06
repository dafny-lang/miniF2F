// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_668(l: int, r: int, inv2: int, inv3: int)
  requires 0 <= l < 7
  requires 0 <= r < 7
  requires 0 <= inv2 < 7
  requires 0 <= inv3 < 7
  requires (inv2*2) % 7 == 1
  requires (inv3*3) % 7 == 1
  requires (l*(2+3)) % 7 == 1
  requires r == (inv2 + inv3)%7
  ensures (l - r)%7 == 1
{}