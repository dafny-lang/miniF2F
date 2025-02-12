include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_236()
  ensures pow(1999, 2000) % 5 == 1
{
  assert pow(1999, 2000) % 5 == (pow(1999 % 5, 2000) % 5);
  assert pow(1999 % 5, 2000) % 5 == pow(4, 2000) % 5;
  assert pow(4, 2000) % 5 == pow((pow(4, 2) % 5), 1000) % 5;
  assert pow(4, 2) % 5 == 1;
  assert pow(1, 1000) % 5 == 1;
}