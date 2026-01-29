include "../definitions.dfy"
include "../library.dfy"

lemma aimeII_2020_p6(t: nat -> rat)
  requires t(1) == Rational(20, 1)
  requires t(2) == Rational(21, 1)
  requires forall n | n >= 3 :: (Rat.mul(Rational(25, 1), t(n-2)).num != 0) && t(n) == Rat.div(Rat.add(Rat.mul(Rational(5, 1), t(n-1)), Rational(1, 1)), Rat.mul(Rational(25, 1), t(n-2)))
  ensures t(2020).denom + t(2020).num == 626
{}