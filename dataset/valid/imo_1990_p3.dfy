// Author: Stefan Zetzsche

include "../utils.dfy"

lemma imo_1990_p3(n: nat)
  requires 2 <= n
  requires Int.pow(n, 2) % (Int.pow(2, n) + 1) == 0
  ensures n == 3
{}