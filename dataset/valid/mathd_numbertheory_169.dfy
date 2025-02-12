include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_169()
  ensures gcd(factorial(20), 200000) == 40000
{}