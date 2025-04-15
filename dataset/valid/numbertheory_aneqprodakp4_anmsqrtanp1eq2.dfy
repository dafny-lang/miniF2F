// Author: Stefan Zetzsche

include "../utils.dfy"

lemma numbertheory_aneqprodakp4_anmsqrtanp1eq2(a: nat -> real)
  requires forall n: nat :: a(n) >= 0.0 // added
  requires a(0) == 1.0
  requires forall n: nat :: a(n+1) == Real.prod(range(n+1), k => a(k)) + 4.0
  ensures forall n: nat | n >= 1 :: a(n) - sqrt(a(n+1)) == 2.0
{}