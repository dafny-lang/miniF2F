// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_246(a: real, b: real, f: real -> real)
  requires forall x :: f(x)== a*x*x*x*x - b*x*x + x + 5.0
  requires f(-3.0) == 2.0
  ensures f(3.0) == 8.0
{}