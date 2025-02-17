include "../utils.dfy"

lemma numbertheory_prmdvsneqnsqmodpeq0(n: int, p: nat)
  requires prime(p)
  ensures n % p == 0 <==> n*n % p == 0
{}