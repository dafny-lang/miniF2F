// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma aime_1988_p8(f: nat -> nat -> real)
  requires forall x: nat | 0 < x :: f(x)(x) == (x as real)
  requires forall x, y: nat | 0 < x && 0 < y :: f(x)(y) == f(y)(x)
  requires forall x, y: nat | 0 < x && 0 < y :: ((x+y) as real)*f(x)(y) == (y as real)*f(x)(x+y)
  ensures f(14)(52) == 364.0
{}