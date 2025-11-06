// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma imo_1974_p3(n: nat)
  ensures Int.sum(range(n), k => choose(2*n+1, 2*k+1)*Int.pow(2, 3*k)) % 5 != 0
{}