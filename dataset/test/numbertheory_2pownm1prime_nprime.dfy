include "../definitions.dfy"
include "../library.dfy"

lemma numbertheory_2pownm1prime_nprime(n: nat)
  requires 0 < n
  requires prime(Int.pow(2, n) - 1)
  ensures prime(n)
{}