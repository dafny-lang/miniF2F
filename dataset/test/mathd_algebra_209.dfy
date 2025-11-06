// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_209(f: real -> real, g: real -> real)
  requires forall x :: f(g(x)) == x
  requires forall x :: g(f(x)) == x
  requires g(2.0) == 10.0
  requires g(10.0) == 1.0
  requires g(1.0) == 2.0
  ensures f(f(10.0)) == 1.0
{}