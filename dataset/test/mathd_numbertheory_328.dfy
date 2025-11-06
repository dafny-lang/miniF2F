// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_328()
  ensures Int.pow(5, 999999) % 7 == 6
{}