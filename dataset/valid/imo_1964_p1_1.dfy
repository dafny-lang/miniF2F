include "../definitions.dfy"
include "../library.dfy"

lemma imo_1964_p1_1(n: nat)
  requires n != 0 // added this
  requires 7 % (Int.pow(2, n) - 1) == 0
  ensures 3 % n == 0
{}