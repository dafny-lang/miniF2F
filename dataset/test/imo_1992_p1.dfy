// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma imo_1992_p1(p: int, q: int, r: int)
  requires 1 < p < q < r
  requires (p*q*r - 1) % ((p-1)*(q-1)*(r-1)) == 0
  ensures (p, q, r) == (2, 4, 8) || (p, q, r) == (3, 5, 15)
{}