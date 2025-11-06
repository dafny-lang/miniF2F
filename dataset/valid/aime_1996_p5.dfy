// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma aime_1996_p5(a: real, b: real, c: real, r: real, s: real, t: real, f: real -> real, g: real -> real)
  requires forall x :: f(x) == x*x*x + 3.0*x*x + 4.0*x - 11.0
  requires forall x :: g(x) == x*x*x + r*x*x + s*x + t
  requires f(a) == 0.0
  requires f(b) == 0.0
  requires f(c) == 0.0
  requires g(a+b) == 0.0
  requires g(b+c) == 0.0
  requires g(c+a) == 0.0
  requires a != b
  requires b != c
  requires a != c
  ensures t == 23 as real
{}