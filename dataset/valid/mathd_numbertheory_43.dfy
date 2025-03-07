// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_43()
  ensures is_greatest(iset n: nat | factorial(942) % Int.pow(15, n) == 0, 233)
{}