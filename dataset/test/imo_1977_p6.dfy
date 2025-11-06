// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma imo_1977_p6(f: nat -> nat)
  requires forall n: nat :: 0 < f(n)
  requires forall n: nat :: 0 < n ==> f(f(n)) < f(n + 1)
  ensures forall n: nat :: 0 < n ==> f(n) == n
{}
