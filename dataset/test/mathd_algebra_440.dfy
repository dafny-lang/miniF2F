// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_440(x: real)
  requires 3.0 / 2.0 / 3.0 == x / 10.0
  ensures x == 5.0
{}