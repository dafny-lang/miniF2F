include "../utils.dfy"

lemma aime_1997_p9(a: real)
  requires 0.0 < a
  requires (1.0/a) - (1.0/a).Floor as real == a*a - floor(a*a) as real
  requires 2.0 < a*a
  requires a*a < 3.0
  ensures Real.pow(a, 12) - 144.0 * (1.0/a) == 233.0
{}