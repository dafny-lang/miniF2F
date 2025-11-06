// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_77(a: real, b: real, f: real -> real)
  requires a != 0.0
  requires b != 0.0
  requires forall x :: f(x) == x*x + a*x + b
  requires f(a) == 0.0
  requires f(b) == 0.0
  ensures a == 1.0
  ensures b == -2.0
{}