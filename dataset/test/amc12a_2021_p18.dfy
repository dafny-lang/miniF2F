// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12a_2021_p18(f: rat -> real)
  requires forall x, y: rat | Rat.le(Rat.zero(), x) && Rat.le(Rat.zero(), y) :: f(Rat.mul(x, y)) == (f(x) as real) + (f(y) as real)
  requires forall p: int | prime(p) :: f(Rat.of_int(p)) == (p as real)
  ensures f(Rational(25, 11)) < 0.0
{}