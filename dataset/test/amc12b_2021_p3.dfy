// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12b_2021_p3(x: real)
  requires (3.0 + x) != 0.0 // added
  requires (2.0 + 2.0 / (3.0 + x)) != 0.0 // added
  requires 1.0 / (2.0 + 2.0 / (3.0 + x)) != 0.0 // added
  requires (1.0 + 1.0 / (2.0 + 2.0 / (3.0 + x))) != 0.0 // added
  requires 2.0 + 1.0 / (1.0 + 1.0 / (2.0 + 2.0 / (3.0 + x))) == 144.0 / 53.0
  ensures x == 3.0 / 4.0
{}