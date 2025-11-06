// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma induction_12dvd4expnp1p20(n: nat)
  ensures (Int.pow(4, n+1) + 20) % 12 == 0
{
  if n == 0 {
    // Base case: n = 0
    assert Int.pow(4, 0 + 1) == 4;
    assert 4 + 20 == 24;
    assert 24 % 12 == 0;
  } else {
    // Inductive step: Assume for n-1 and prove for n
    induction_12dvd4expnp1p20(n - 1);

    // Use the inductive hypothesis: (4^n + 5) % 3 == 0
    // This means 4^n + 5 is divisible by 3
    // Then 4^{n+1} + 20 = 4 * 4^n + 20 = 4 * (4^n + 5)
    // So it is divisible by 4 * 3 = 12

    // We'll prove this step-by-step

    // First, we note that 4^n + 5 is divisible by 3
    var k := (Int.pow(4, n) + 5) / 3;
    assert (Int.pow(4, n) + 5) == 3 * k;

    // Then, 4^{n+1} + 20 = 4 * 4^n + 20
    assert Int.pow(4, n+1) + 20 == 4 * Int.pow(4, n) + 20;

    // We can rewrite 4 * Int.pow(4, n) + 20 as 4 * (Int.pow(4, n) + 5)
    assert Int.pow(4, n+1) + 20 == 4 * (Int.pow(4, n) + 5);

    // Since Int.pow(4, n) + 5 == 3 * k, we have:
    assert Int.pow(4, n+1) + 20 == 4 * 3 * k;

    // Finally, 4 * 3 * k is divisible by 12
    assert (4 * 3 * k) % 12 == 0;

    // Therefore, (Int.pow(4, n+1) + 20) % 12 == 0
    assert (Int.pow(4, n+1) + 20) % 12 == 0;
  }
}