// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_28(c: real, f: real -> real)
  requires forall x :: f(x) == 2.0*x*x + 5.0*x + c
  requires exists x :: f(x) <= 0.0
  ensures c <= 25.0/8.0
{}