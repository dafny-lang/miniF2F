// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma numbertheory_sqmod3in01d(a: int)
  ensures (a*a) % 3 == 0 || (a*a) % 3 == 1
{}