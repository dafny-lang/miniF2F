// Author: Stefan Zetzsche

include "../utils.dfy"

lemma aime_1984_p1(u: nat -> rat)
  requires forall n: nat :: Rat.eq(u(n+1), Rat.add(u(n), Rational(1, 1)))
  requires Rat.eq(Rat.sum(range(98), (k: nat) => u(k+1)), Rational(137, 1))
  ensures Rat.eq(Rat.sum(range(49), (k: nat) => u(2*(k+1))), Rational(93, 1))
{}