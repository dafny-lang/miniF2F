include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_236()
  ensures pow(1999, 2000) % 5 == 1
{
  assert pow(1999, 2000) % 5 == (1999 % 5) ^ 2000 % 5;
  assert (1999 % 5) == 4;
  assert 4 ^ 2000 % 5 == (4 ^ 2) ^ 1000 % 5;
  assert (4 ^ 2) % 5 == 1;
  assert 1 ^ 1000 % 5 == 1;
}