// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_629()
  ensures is_least(set t: nat | 0 < t <= 18 && (Int.pow(lcm(12, t), 3) == Int.pow(12*t, 2)), 18)
{}