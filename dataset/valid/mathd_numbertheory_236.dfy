// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_236()
  ensures Int.pow(1999, 2000) % 5 == 1
{}