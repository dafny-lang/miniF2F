// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_303(s: set<nat>)
  requires forall n :: n in s <==> (2 <= n && (171 % n == 80 % n) && (468 % n == 13 % n))
  ensures Int.sum(s, k => k) == 111
{}