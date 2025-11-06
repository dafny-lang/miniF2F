// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_221(s: set<nat>)
  requires forall x: nat :: x in s <==> (0 < x < 1000 && |divisors(x)| == 3)
  ensures |s| == 11
{}