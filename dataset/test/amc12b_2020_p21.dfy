// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12b_2020_p21(s: set<nat>)
  requires forall n :: n in s <==> (0 < n && ((n as real) + 1000.0)/70.0 == floor(sqrt(n as real)) as real)
  ensures |s| == 6
{}