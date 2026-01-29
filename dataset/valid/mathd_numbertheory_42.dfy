include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_42(s: iset<nat>, u: nat, v: nat)
  requires forall a: nat :: a in s <==> (0 < a && ((27*a)%40 == 17))
  requires is_least(s, u)
  requires is_least(s - iset{u}, v)
  ensures u+v == 62
{}