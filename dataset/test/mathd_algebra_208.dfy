// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_208()
  ensures sqrt(1000000.0) - Real.rpow(1000000.0, 1.0/3.0) == 900.0
{}