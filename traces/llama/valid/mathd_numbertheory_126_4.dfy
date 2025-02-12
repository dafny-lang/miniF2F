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
  gcd(a, 40) == x + 3;
  lcm(a, 40) == x * (x + 3);
  assert gcd(a, 40) == x + 3;
  assert lcm(a, 40) == x * (x + 3);
  assert x > 0 by { assert x + 3 > 0; assert gcd(a, 40) > 0; };
  assert x + 3 <= 40 by { assert gcd(a, 40) <= 40; };
  assert x + 3 == 1 || x + 3 == 2 || x + 3 == 4 || x + 3 == 5 || x + 3 == 8 || x + 3 == 10 || x + 3 == 20 || x + 3 == 40;
  if x + 3 == 1 then {
    assert false;
  } else if x + 3 == 2 then {
    assert false;
  } else if x + 3 == 4 then {
    assert false;
  } else if x + 3 == 5 then {
    assert false;
  } else if x + 3 == 8 then {
    assert x == 5;
    assert lcm(a, 40) == 5 * 8;
    assert lcm(a, 40) == 40;
    assert a == 8;
  } else if x + 3 == 10 then {
    assert false;
  } else if x + 3 == 20 then {
    assert false;
  } else if x + 3 == 40 then {
    assert false;
  }
}