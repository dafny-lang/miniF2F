include "../utils.dfy"

lemma mathd_algebra_160(n: real, x: real)
  requires n + x == 97.0
  requires n + 5.0*x == 265.0
  ensures n + 2.0*x == 139.0
{}