// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_412(x: real, y: real)
  requires x + y == 25.0
  requires x - y == 11.0
  ensures x == 18.0
{}