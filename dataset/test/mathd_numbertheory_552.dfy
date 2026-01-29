include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_552(f: nat -> nat, g: nat -> nat, h: nat -> nat, range_of_h: set<nat>)
  requires forall x: nat :: f(x) == 12*x + 7
  requires forall x: nat :: g(x) == 5*x + 2
  requires forall x: nat :: h(x) == gcd(f(x), g(x))
  requires (iset x | x in range_of_h :: x) == iset x :: h(x)
  ensures Int.sum(range_of_h, k => k) == 12
{}