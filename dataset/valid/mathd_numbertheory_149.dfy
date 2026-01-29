include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_149()
  ensures Int.sum(filter(x => (x % 8 == 5) && (x % 6 == 3), range(50)), k => k) == 66
{}