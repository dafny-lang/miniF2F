include "../utils.dfy"

import opened Utils

lemma aime_1988_p3(x: real)
  requires 0.0 < x
  requires logb(2.0, logb(8.0, x)) == logb(8.0, logb(2.0, x))
{}