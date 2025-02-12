include "../utils.dfy"

import opened Utils

// issue with bracketing
lemma mathd_numbertheory_126(x: nat, a: nat)
  requires 0 < x 
  requires 0 < a
  requires gcd(a, 40) == x + 3
  requires lcm(a, 40) == x*(x+3)
  requires forall b: nat :: (0 < b ==> gcd(b, 40) == x+3) && (lcm(b, 40) == x*(x+3) ==> a <= b)
  ensures a == 8
{}