include "../utils.dfy"

lemma mathd_algebra_224(s: set<nat>)
  requires forall n: nat :: n in s <==> 2.0 < sqrt(n as real) < 7.0/2.0
  ensures |s| == 8 
{}