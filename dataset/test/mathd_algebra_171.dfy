include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_171(f: real -> real)
  requires forall x :: f(x) == 5.0*x + 4.0
  ensures f(1.0) == 9.0
{}