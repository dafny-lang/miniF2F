include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_462()
  ensures Rat.eq(Rat.mul(Rat.add(Rational(1, 2), Rational(1, 3)), Rat.sub(Rational(1, 2), Rational(1, 3))),  Rational(5, 36))
{}