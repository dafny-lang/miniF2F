// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12b_2002_p3(s: set<nat>)
  requires forall n :: n in s <==> 0 < n && prime(n*n + 2 - 3*n)
  ensures |s| == 1
{}