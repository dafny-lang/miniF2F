include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2020_p10(n: nat)
  requires 0 < n
  requires logb(2.0, logb(16.0, n as real)) == logb(4.0, logb(4.0, n as real))
  ensures Int.sum(set x | x in digits(10, n), (k: int) => k) == 13
{}