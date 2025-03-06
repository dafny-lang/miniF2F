// Author: Stefan Zetzsche

include "../utils.dfy"

lemma aime_1983_p2(x: real, p: real, f: real -> real)
  requires 0.0 < p < 15.0
  requires p <= x <= 15.0
  requires f(x) == abs(x - p) + abs(x - 15.0) + abs(x - p - 15.0)
  ensures 15.0 <= f(x)
{}