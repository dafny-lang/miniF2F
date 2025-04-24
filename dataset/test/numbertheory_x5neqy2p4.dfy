// Author: Stefan Zetzsche

include "../utils.dfy"

lemma numbertheory_x5neqy2p4(x: int, y: int)
  ensures Int.pow(x, 5) != Int.pow(y, 2) + 4
{}