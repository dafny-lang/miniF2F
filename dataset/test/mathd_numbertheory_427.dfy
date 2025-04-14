// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_427(a: nat)
  requires a == Int.sum(divisors(500), k => k)
  ensures Int.sum(filter(prime, divisors(a as int)), k => k) == 25
{}