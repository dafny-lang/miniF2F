// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_618(n: nat, p: nat -> nat)
  requires forall x: nat :: p(x) == x*x - x + 41
  requires 1 < gcd(p(n), p(n+1))
  ensures 41 <= n
{}