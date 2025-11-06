// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_107(x: real, y: real)
  requires x*x + 8.0*x + y*y - 6.0*y == 0.0
  ensures (x+4.0)*(x+4.0) + (y-3.0)*(y-3.0) == 5.0*5.0
{}