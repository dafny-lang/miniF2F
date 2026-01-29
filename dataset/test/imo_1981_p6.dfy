include "../definitions.dfy"
include "../library.dfy"

lemma imo_1981_p6(f: nat -> nat -> nat)
  requires forall y: nat :: f(0)(y) == y + 1
  requires forall x: nat :: f(x+1)(0) == f(x)(1)
  requires forall x: nat, y: nat :: f(x+1)(y+1) == f(x)(f(x+1)(y))
  ensures forall y: nat :: f(4)(y+1) == Int.pow(2, f(4)(y+3)) - 3
{}