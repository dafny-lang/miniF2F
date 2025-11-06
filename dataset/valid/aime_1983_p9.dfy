// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma aime_1983_p9(x: real)
  requires 0.0 < x < pi()
  ensures (x * sin(x)) != 0.0
  ensures 12.0 <= (9.0*(x*x + sin(x)*sin(x)) + 4.0) / (x * sin(x))
{}