// Author: Stefan Zetzsche

include "../utils.dfy"

lemma numbertheory_x5neqy2p4(x: int, y: int)
  ensures power(x, 5) != power(y, 2) + 4
{}