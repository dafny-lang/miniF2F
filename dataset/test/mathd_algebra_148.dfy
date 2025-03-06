// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_148(c: real, f: real -> real)
  requires forall x :: f(x) == c + x*x*x - 9.0*x + 3.0
  requires f(2.0) == 9.0
  ensures c == 3.0
{}