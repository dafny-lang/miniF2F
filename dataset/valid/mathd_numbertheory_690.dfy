// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_690()
  ensures is_least(set a: nat | 0 < a <= 314 && (a%3 == 2%3) && (a%5 == 4%5) && (a%7 == 6%7) && (a%9 == 8%9), 314)
{}