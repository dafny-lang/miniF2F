// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma imo_1993_p5()
  ensures exists f: nat -> nat :: f(1) == 2 && forall n: nat :: f(f(n)) == f(n) + n && f(n) < f(n+1)
{}