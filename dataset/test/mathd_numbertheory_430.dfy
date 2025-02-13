include "../utils.dfy"

lemma mathd_numbertheory_430(a: nat, b: nat, c: nat)
  requires 1 <= a <= 9
  requires 1 <= b <= 9
  requires 1 <= c <= 9
  requires a != b
  requires a != c
  requires b != c
  requires a + b == c
  requires 10 * a + a - b == 2 * c
  requires c * b == 10 * a + a + a
  ensures a + b + c == 8
{}