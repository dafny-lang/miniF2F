// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_495(a: nat, b: nat)
  requires 0 < a
  requires 0 < b
  requires a % 10 == 2
  requires b % 10 == 4
  requires gcd(a, b) == 6
  ensures 108 <= lcm(a, b)
{}