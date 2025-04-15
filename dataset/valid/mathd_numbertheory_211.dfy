// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_211()
  ensures |filter(n => (4*n - 2) % 6 == 0, range(60))| == 20
{}