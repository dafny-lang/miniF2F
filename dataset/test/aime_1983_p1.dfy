// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma aime_1983_p1(x: nat, y: nat, z: nat, w: nat)
  requires 1 < x
  requires 1 < y
  requires 1 < z
  requires 0 <= w
  requires log(x as real) != 0.0
  requires log(y as real) != 0.0
  requires log((x as real)*(y as real)*(z as real)) != 0.0
  requires log(z as real) != 0.0
  requires log(w as real)/log(x as real) == 24.0
  requires log(w as real)/log(y as real) == 40.0
  requires log(w as real)/log((x as real)*(y as real)*(z as real)) == 12.0
  ensures log(w as real)/log(z as real) == 60.0
{}