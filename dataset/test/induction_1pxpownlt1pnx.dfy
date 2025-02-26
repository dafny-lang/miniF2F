include "../utils.dfy"

lemma induction_1pxpownlt1pnx(x: real, n: nat)
  requires -1.0 < x
  requires 0 < n
  ensures 1.0 + (n as real)*x <= Real.pow(1.0+x, n)
{}