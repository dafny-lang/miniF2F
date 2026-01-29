include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_629()
  ensures is_least(iset t: nat | 0 < t && (Int.pow(lcm(12, t), 3) == Int.pow(12*t, 2)), 18)
{}