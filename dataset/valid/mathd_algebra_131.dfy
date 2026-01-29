include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_131(a: real, b: real, f: real -> real)
  requires forall x :: f(x) == 2.0*x*x - 7.0*x + 2.0
  requires f(a) == 0.0
  requires f(b) == 0.0
  requires a != b
  ensures 1.0/(a - 1.0) + 1.0/(b - 1.0) == -1.0
{}