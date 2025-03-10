// Author: Stefan Zetzsche

include "../utils.dfy"

lemma aime_1984_p5(a: real, b: real)
  requires logb(8.0, a) + logb(4.0, b*b) == 5.0
  requires logb(8.0, b) + logb(4.0, a*a) == 7.0
{}