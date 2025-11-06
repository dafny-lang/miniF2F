// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2020_p4(s: set<nat>)
  requires forall n: nat :: n in s <==> ((1000 <= n <= 9999) && (forall d: nat :: (d in digits(10, n)) ==> ((d % 2) == 0)) && (n % 5 == 0))
  ensures |s| == 100
{}