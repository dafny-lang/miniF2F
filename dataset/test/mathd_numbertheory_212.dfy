include "../utils.dfy"

lemma mathd_numbertheory_212()
  ensures (Int.pow(16, 17) * Int.pow(17, 18) * Int.pow(18, 19)) % 10 == 8
{}