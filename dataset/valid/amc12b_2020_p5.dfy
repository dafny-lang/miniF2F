// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12b_2020_p5(a: nat, b: nat)
  requires 5.0/8.0 * (b as real) == 2.0/3.0 * (a as real) + 7.0
  requires (b as real) - 5.0/8.0 * (b as real) == (a as real) - 2.0/3.0 * (a as real) + 7.0
  ensures a == 42
{}