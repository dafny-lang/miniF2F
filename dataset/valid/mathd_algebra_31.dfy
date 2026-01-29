include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_31(x : real, u : nat -> real)
  requires forall n : nat :: u(n + 1) == sqrt(x + u (n))
  requires limit(u, 9.0)
  ensures 9.0 == sqrt(x + 9.0)
{}