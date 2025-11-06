// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma aime_1999_p11(m: rat)
  requires m.num != 0
  requires Real.sum(set k: int | 1 <= k <= 35 :: k, (k: int) => sin(5.0*(k as real)*pi()/180.0)) == tan(m.to_real()*pi()/180.0)
  requires (m.denom as real)/(m.num as real) < 90.0
  ensures m.denom + m.num == 177
{}