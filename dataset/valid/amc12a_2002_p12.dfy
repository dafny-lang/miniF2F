include "../utils.dfy"

lemma amc12a_2002_p12(f: real -> real, k: real)
  requires forall x :: f(x) == x*x - 63.0*x + k
  requires (iset x | f(x) == 0.0) <= (iset x | exists n: nat :: (n as real) == x && prime(n))
  ensures k == 122.0
{}