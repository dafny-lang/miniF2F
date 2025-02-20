include "../utils.dfy"

lemma aime_1987_p8(n: nat)
  requires 0 < n
  requires exists k :: n+k != 0 && 8/15 < n/(n+k) < 7/13
  ensures n <= 112
{}