include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2020_p7(f: nat -> nat)
  requires Int.pow(f(0), 3) == 1
  requires Int.pow(f(1), 3) == 8
  requires Int.pow(f(2), 3) == 27
  requires Int.pow(f(3), 3) == 64
  requires Int.pow(f(4), 3) == 125
  requires Int.pow(f(5), 3) == 216
  requires Int.pow(f(6), 3) == 343
  ensures Int.sum(range(7), k => 6*Int.pow(f(k), 2)) - 2*Int.sum(range(6), k => Int.pow(f(k), 2)) == 658
{}