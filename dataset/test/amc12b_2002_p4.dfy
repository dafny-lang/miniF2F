include "../definitions.dfy"
include "../library.dfy"

lemma amc12b_2002_p4(n: nat)
  requires 0 < n
  requires Rat.add(Rat.add(Rat.add(Rational(1, 2), Rational(1, 3)), Rational(1, 7)), Rational(1, n)).denom == 1
  ensures n == 42
{}