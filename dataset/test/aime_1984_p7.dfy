include "../utils.dfy"

lemma aime_1984_p7(f: int -> int)
  requires forall n: int | 1000 <= n :: f(n) == n-3
  requires forall n: int | n < 1000 :: f(n) == f(f(n+5))
  ensures f(84) == 997
{}