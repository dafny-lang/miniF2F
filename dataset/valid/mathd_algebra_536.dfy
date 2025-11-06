// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_536()
  ensures ((factorial(3) as real)*(Real.pow(2.0, 3) + sqrt(9.0))) / 2.0 == 33.0
{}