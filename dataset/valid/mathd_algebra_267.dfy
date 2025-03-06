// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_267(x: real)
  requires x != 1.0
  requires x != -2.0
  requires (x + 1.0) / (x - 1.0) == (x - 2.0) / (x + 2.0)
  ensures x == 0.0
{}