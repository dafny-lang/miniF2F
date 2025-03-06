// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_76(f: int -> int)
  requires forall n | n % 2 == 1 :: f(n) == n*n
  requires forall n | n % 2 == 0 :: f(n) == n*n - 4*n - 1
  ensures f(4) == -1
{}