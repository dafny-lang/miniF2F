include "../utils.dfy"

lemma numbertheory_aoddbdiv4asqpbsqmod8eq1(a: int, b: nat)
  requires a % 2 == 1
  requires b % 4 == 0
  ensures (a*a + b*b) % 8 == 1
{}