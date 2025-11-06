// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_3()
  ensures Int.sum(range(10), (x: int) => ((x+1)*(x+1))) % 10 == 5
{}