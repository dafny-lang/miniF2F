// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_419(a: real, b: real) 
  requires a == -1.0
  requires b == 5.0
  ensures -a - b*b + 3.0 * (a * b) == -39.0
{}
