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
 ```dafny
{
  // We know that gcd(a, 40) = x + 3 and lcm(a, 40) = x * (x + 3)
  // We also know that gcd(a, 40) * lcm(a, 40) = a * 40
  // So, we have (x + 3) * x * (x + 3) = a * 40
  assert (x + 3) * x * (x + 3) == a * 40;

  // Simplifying the equation
  assert x * (x + 3) * (x + 3) == a * 40;

  // We also know that lcm(a, 40) = x * (x + 3)
  // So, we have x * (x + 3) % 40 == 0
  assert x * (x + 3) % 40 == 0;

  // Since x * (x + 3) % 40 == 0, x * (x + 3) must be a multiple of 40
  // Let's try to find a value of x that satisfies the equation
  // We know that x > 0, so we can try different values of x
  // If x = 1, then x * (x + 3) = 4, which is not a multiple of 40
  // If x = 2, then x * (x + 3) = 10, which is not a multiple of 40
  // If x = 3, then x * (x + 3) = 18, which is not a multiple of 40
  // If x = 4, then x * (x + 3) = 28, which is not a multiple of 40
  // If x = 5, then x * (x + 3) = 40, which is a multiple of 40
  assert x == 5;

  // Now we can substitute x = 5 into the equation
  // We have (5 + 3) * 5 * (5 + 3) = a * 40
  // Simplifying the equation
  assert 8 * 5 * 8 * 8 == a * 40;

  // Solving for a
  assert 200 == a * 40;

  // Dividing both sides by 40
  assert 5 == a;
}
```