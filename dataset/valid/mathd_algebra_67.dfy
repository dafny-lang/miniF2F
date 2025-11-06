// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_67(f: real -> real, g: real -> real)
  requires forall x :: f(x) == 5.0 * x + 3.0
  requires forall x :: g(x) == x*x - 2.0
  ensures g(f(-1.0)) == 2.0
{}