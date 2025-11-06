// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_263(y: real)
  requires sqrt(19.0 + 3.0*y) == 7.0
  ensures y == 10.0
{}