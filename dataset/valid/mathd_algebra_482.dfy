include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_482(m: nat, n: nat, k: real, f: real -> real)
  requires prime(m)
  requires prime(n)
  requires forall x :: f(x) == x*x - 12.0 *x + k
  requires f(m as real) == 0.0
  requires f(n as real) == 0.0
  requires m != n
  ensures k == 35.0
{}