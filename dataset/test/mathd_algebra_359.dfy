include "../utils.dfy"

lemma mathd_algebra_359(y: real)
  requires y + 6.0 + y == 2.0 * 12.0
  ensures y == 9.0
{}