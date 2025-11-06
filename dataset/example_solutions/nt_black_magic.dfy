// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12_2000_p6(p: nat, q: nat)
  requires prime(p)
  requires prime(q)
  requires 4 <= p <= 18
  requires 4 <= q <= 18
  ensures p*q - (p+q) != 194
{
  assert 195 % 2 == 1;  // 195 is odd
  assert 4 % 2 == 0;    // 4 is even
  assert 6 % 2 == 0;    // 6 is even
  assert 10 % 2 == 0;   // 10 is even
  assert 12 % 2 == 0;   // 12 is even
  assert 16 % 2 == 0;   // 16 is even
}