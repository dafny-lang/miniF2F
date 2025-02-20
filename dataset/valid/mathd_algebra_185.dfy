include "../utils.dfy"

lemma mathd_algebra_185(s: set<int>, f: int -> int)
  requires forall x :: f(x) as real == abs((x+4) as real)
  requires forall x :: x in s <==> f(x) < 9
  ensures |s| == 17
{}