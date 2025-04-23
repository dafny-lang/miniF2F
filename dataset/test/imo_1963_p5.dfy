// Author: Stefan Zetzsche

include "../utils.dfy"

lemma imo_1963_p5()
  ensures cos(pi() / 7.0) - cos(2.0 * (pi() / 7.0)) + cos(3.0* (pi() / 7.0)) == 1.0/2.0
{}