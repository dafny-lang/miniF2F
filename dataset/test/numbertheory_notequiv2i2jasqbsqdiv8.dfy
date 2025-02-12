include "../utils.dfy"

import opened Utils

lemma numbertheory_notequiv2i2jasqbsqdiv8(a: int, b: int)
  ensures !((exists i, j :: a == 2*i && b == 2*j) <==> (exists k :: a*a + b*b == 8*k))
{}