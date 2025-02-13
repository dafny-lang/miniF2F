include "../utils.dfy"

lemma mathd_algebra_142(m: real, b: real)
  requires m*7.0 + b == -1.0
  requires m*-1.0 + b == 7.0
  ensures m + b == 5.0
{}