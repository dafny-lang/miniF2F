// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_22()
  ensures logb(Real.pow(5.0, 2), Real.pow(5.0, 4)) == 2.0
{}