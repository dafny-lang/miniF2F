include "../definitions.dfy"
include "../library.dfy"

lemma imo_2007_p6(f: nat -> real)
  requires Real.sum(range(100), x => f(x+1)*f(x+1)) == 1.0
  ensures Real.sum(range(99), x => f(x+1)*f(x+1) + f(x+2) + f(100)*f(100)*f(1)) < 12.0/25.0
{}