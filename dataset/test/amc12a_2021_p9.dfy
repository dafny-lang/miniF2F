// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12a_2021_p9()
  ensures Int.prod(range(7), k => Int.pow(2, Int.pow(2, k) + Int.pow(3, Int.pow(3, k)))) == Int.pow(3, 128) - Int.pow(2, 128)
{}