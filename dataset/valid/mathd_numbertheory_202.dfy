include "../utils.dfy"

lemma mathd_numbertheory_202()
  ensures Int.pow(19, 19) + Int.pow(99, 99) % 10 == 8
{}