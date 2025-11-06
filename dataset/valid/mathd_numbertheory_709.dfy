// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_709(n: nat)
  requires 0 < n
  requires |divisors(2*n)| == 28
  requires |divisors(3*n)| == 30
  ensures |divisors(6*n)| == 35
{}