// Author: Stefan Zetzsche

include "../utils.dfy"

lemma aime_1991_p9(x: real, m: rat)
  requires cos(x) != 0.0
  requires sin(x) != 0.0
  requires tan(x) != 0.0
  requires 1.0/cos(x) + tan(x) == 22.0/7.0
  requires 1.0/sin(x) + 1.0/tan(x) == m.to_real()
  ensures m.denom + m.num == 44
{}