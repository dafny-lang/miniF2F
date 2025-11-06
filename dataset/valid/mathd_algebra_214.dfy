// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_214(a: real, f: real -> real)
  requires forall x :: f(x) == a*(x-2.0)*(x-2.0) + 3.0
  requires f(4.0) == 4.0
  ensures f(6.0) == 7.0
{}