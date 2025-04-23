// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12a_2003_p25(a: real, b: real, f: real -> real)
  requires 0.0 < b
  requires forall x :: f(x) == sqrt(a*x*x + b*x)
  requires (iset x | 0.0 <= f(x) :: x) == (iset x | 0.0 <= f(x) :: f(x))
  ensures a == 0.0 || a == -4.0
{}