// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma algebra_sum1onsqrt2to1onsqrt10000lt198()
  ensures Real.sum(set k | 2 <= k <= 10000, (k: int) => if k as real <= 0.0 then 0.0 else 1.0/sqrt(k as real)) < 198.0
{}