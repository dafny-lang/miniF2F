include "../utils.dfy"

lemma mathd_algebra_392(n: nat)
  requires n % 2 == 0
  requires (n-2)*(n-2) + n*n + (n+2)*(n+2) == 12296
  ensures (n-2)*n*(n+2) / 8 == 32736
{}