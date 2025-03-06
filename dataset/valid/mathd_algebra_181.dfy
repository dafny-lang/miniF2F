// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_181(n: real)
  requires n != 3.0
  requires (n + 5.0) / (n - 3.0) == 2.0
  ensures n == 11.0
{}
