// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma aime_1983_p2(x: real, p: real, f: real -> real)
  requires 0.0 < p < 15.0
  requires p <= x <= 15.0
  requires f(x) == Real.abs(x - p) + Real.abs(x - 15.0) + Real.abs(x - p - 15.0)
  ensures 15.0 <= f(x)
{}