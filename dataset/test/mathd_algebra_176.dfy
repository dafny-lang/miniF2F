// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_176(x: real)
  ensures (x + 1.0)*(x + 1.0) * x == x*x*x + 2.0*x*x + x
{}