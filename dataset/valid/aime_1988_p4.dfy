// Author: Stefan Zetzsche

include "../utils.dfy"

lemma aime_1988_p4(n: nat, a: nat -> real)
  requires forall n :: abs(a(n)) < 1.0
  requires Real.sum(range(n), k => abs(a(k))) == 19.0 + abs(Real.sum(range(n), k => a(k)))
  ensures 20 <= n
{}