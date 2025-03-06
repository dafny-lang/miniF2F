// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_568(a: real)
  ensures (a-1.0)*(a+1.0)*(a+2.0) - (a-2.0)*(a+1.0) == a*a*a + a*a
{}