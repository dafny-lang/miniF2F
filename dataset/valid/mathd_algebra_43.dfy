// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_43(a: real, b: real, f: real -> real)
  requires forall x :: f(x) == a*x + b
  requires f(7.0) == 4.0
  requires f(6.0) == 3.0
  ensures f(3.0) == 0.0
{}