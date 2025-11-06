// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_296()
  ensures Real.abs((3491.0-60.0) * (3491.0+60.0) - 3491.0*3491.0) == 3600.0
{}