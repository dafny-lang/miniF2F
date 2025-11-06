// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2002_p6(n: nat)
  requires 0 < n 
  ensures exists m, p :: m > n && m*p <= m+p
{}