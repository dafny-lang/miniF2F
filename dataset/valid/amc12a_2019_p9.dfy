include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2019_p9(a: nat -> rat)
  requires Rat.eq(a(1), Rat.of_int(1))
  requires Rat.eq(a(2), Rational(3, 7))
  requires forall n: nat :: Rat.sub(Rat.mul(Rat.of_int(2),a(n)), a(n+1)).num != 0 && Rat.eq(a(n+2), Rat.div(Rat.mul(a(n), a(n+1)), Rat.sub(Rat.mul(Rat.of_int(2),a(n)), a(n+1))))
  ensures a(2019).denom + a(2019).num == 8078
{}