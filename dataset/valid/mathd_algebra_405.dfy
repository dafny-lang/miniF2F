// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_405(s: set<nat>)
  requires forall x :: x in s <==> 0 < x && x*x + 4*x + 4 < 20
  ensures |s| == 2
{}