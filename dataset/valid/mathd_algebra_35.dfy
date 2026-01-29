include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_35(p: real -> real, q: real -> real)
  requires forall x :: p(x) == 2.0 - x*x
  requires forall x | x != 0.0 :: q(x) == 6.0/x
  ensures p(q(2.0)) == -7.0
{}