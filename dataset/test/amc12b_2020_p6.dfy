include "../utils.dfy"

lemma amc12b_2020_p6(n: nat)
  requires 9 <= n
  ensures exists x: nat :: (x as real)*(x as real) == (factorial(n+2) as real - factorial(n+1) as real) / (factorial(n) as real)
{}