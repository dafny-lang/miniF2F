// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2009_p6(m: real, n: real, p: real, q: real)
  requires p == rpow(2.0, m)
  requires q == rpow(3.0, n)
  ensures rpow(p,2.0*n) * rpow(q,m) == rpow(12.0,m*n)
{}