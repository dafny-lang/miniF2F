// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_211()
  ensures |filter((n: nat) => (4*n - 2) % 6 == 0, range(60))| == 20
{}