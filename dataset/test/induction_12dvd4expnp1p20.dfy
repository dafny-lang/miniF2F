// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma induction_12dvd4expnp1p20(n: nat)
  ensures (Int.pow(4, n+1) + 20) % 12 == 0
{}