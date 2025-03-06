// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_22(b: nat)
  requires b < 10
  requires sqrt(10.0*(b as real) + 6.0) + sqrt(10.0*(b as real) + 6.0) == 10.0*(b as real) + 6.0
  ensures b as real == 3.0 || b as real == 1.0
{}