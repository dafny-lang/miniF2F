// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma aime_1988_p4(n: nat, a: nat -> real)
  requires forall n :: Real.abs(a(n)) < 1.0
  requires Real.sum(range(n), k => Real.abs(a(k))) == 19.0 + Real.abs(Real.sum(range(n), k => a(k)))
  ensures 20 <= n
{}