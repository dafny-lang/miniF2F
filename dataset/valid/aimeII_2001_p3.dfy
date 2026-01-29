include "../definitions.dfy"
include "../library.dfy"

lemma aimeII_2001_p3(x: nat -> int)
  requires x(1) == 211
  requires x(2) == 375
  requires x(3) == 420
  requires x(4) == 523
  requires forall n | n >= 5 :: x(n) == x(n-1) - x(n-2) + x(n-3) - x(n-4)
  ensures x(531) + x(753) + x(975) == 898
{}