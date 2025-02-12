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
{
  var b := 8;
  assert gcd(b, 40) == 8;
  assert lcm(b, 40) == 40;
  assert 8 == x + 3;
  assert 40 == x * (x + 3);
  assert x == 5;
  assert a <= 8;
  assert 8 <= a;
  assert a == 8;
}