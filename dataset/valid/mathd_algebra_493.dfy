include "../utils.dfy"

lemma mathd_algebra_493(f: real -> real)
  requires forall x | x >= 0.0 :: f(x) == x*x - 4.0*sqrt(x) + 1.0
  ensures f(f(4.0)) == 70.0
{}