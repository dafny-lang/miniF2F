// Author: Stefan Zetzsche

include "../utils.dfy"

lemma imo_1982_p1(f: nat -> nat)
  requires forall m: nat, n: nat | 0 < m && 0 < n :: f(m+n)-f(m)-f(n) == 0 || f(m+n)-f(m)-f(n) == 1
  requires f(2) == 0
  requires 0 < f(3)
  requires f(9999) == 3333
  ensures f(1982) == 660
{}