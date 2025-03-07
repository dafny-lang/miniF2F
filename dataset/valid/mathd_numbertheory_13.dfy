// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_13(u: nat, v: nat, s: iset<nat>)
  requires forall n: nat :: n in s <==> (0 < n && ((14*n)%100 == 46))
  requires is_least(s, u)
  requires is_least(s - iset{u}, v)
  ensures (u+v) / 2 == 64
{}