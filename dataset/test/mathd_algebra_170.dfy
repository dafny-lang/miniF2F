include "../utils.dfy"

lemma mathd_algebra_170(s: set<int>)
  requires forall n: int :: n in s <==> (abs((n as real)-2.0) <= (5 + 6/10) as real)
  ensures |s| == 11
{}