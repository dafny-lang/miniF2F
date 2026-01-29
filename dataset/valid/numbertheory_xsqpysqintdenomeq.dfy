include "../definitions.dfy"
include "../library.dfy"

lemma numbertheory_xsqpysqintdenomeq(x: rat, y: rat)
  requires Rat.add(Rat.mul(x,x), Rat.mul(y,y)).denom == 1
  ensures x.denom == y.denom
{}