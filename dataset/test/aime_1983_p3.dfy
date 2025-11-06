// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma aime_1983_p3(f: real -> real, s: set<real>)
  requires forall x :: f(x) == x*x + 18.0*x + 30.0 - 2.0*sqrt(x*x + 18.0*x + 45.0)
  requires (iset x | x in s :: x) == (iset x | f(x) == 0.0)
  ensures (Real.prod(s, x => x) == 20.0)
{
}