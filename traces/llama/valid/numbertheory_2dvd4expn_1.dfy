include "../utils.dfy"

import opened Utils

lemma numbertheory_2dvd4expn(n: nat)
  requires n != 0
  ensures 2 % power(4, n) == 0
lemma numbertheory_2dvd4expn(n: nat)
  requires n != 0
  ensures 2 % pow(4, n) == 0
{
  assert 4 == 2 * 2;
  assert pow(4, n) == pow(2 * 2, n);
  assert pow(2 * 2, n) == pow(2, n) * pow(2, n);
  assert pow(2, n) * pow(2, n) % 2 == 0;
}