include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_149(f: real -> real, s: set<real>)
  requires forall x | x < -5.0 :: f(x) == x*x + 5.0
  requires forall x | x >= 5.0 :: f(x) == 3.0*x - 8.0
  requires (iset x | x in s :: x) == (iset x | f(x) == 10.0 :: x)
  ensures Real.sum(s, x => x) == 6.0
{}