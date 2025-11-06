// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_169()
  ensures gcd(factorial(20), 200000) == 40000
{}